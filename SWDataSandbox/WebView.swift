//
//  WebView.swift
//  WebView
//
//  Created by Leonore Yardimli on 2021/12/18.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import WebKit

// MARK: - WebViewHandlerDelegate
// For printing values received from web app
protocol WebViewHandlerDelegate {
	func receivedJsonValueFromWebView(value: [String: Any?])
	func receivedStringValueFromWebView(value: String)
}

// MARK: - WebView
struct WebView: UIViewRepresentable, WebViewHandlerDelegate {
	func receivedJsonValueFromWebView(value: [String : Any?]) {
		print("JSON value received from web is: \(value)")
	}
	
	func receivedStringValueFromWebView(value: String) {
		print("String value received from web is: \(value)")
	}
	
	//var url: WebUrlType
	// Viewmodel object
	@ObservedObject var viewModel: ViewModel
	var musicXML: String
	
	// Make a coordinator to co-ordinate with WKWebView's default delegate functions
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> WKWebView {
		// Enable javascript in WKWebView
		//let preferences = WKPreferences()
		//preferences.javaScriptEnabled = true
		//let webPageDefaultPrefs = WKWebpagePreferences()
		//webPageDefaultPrefs.allowsContentJavaScript = true
		
		let configuration = WKWebViewConfiguration()
		configuration.allowsInlineMediaPlayback = true
		// Here "iOSNative" is our delegate name that we pushed to the website that is being loaded
		configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
		//configuration.preferences = preferences
		//configuration.defaultWebpagePreferences = webPageDefaultPrefs
		
		let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
		webView.navigationDelegate = context.coordinator
		webView.allowsBackForwardNavigationGestures = true
		webView.scrollView.isScrollEnabled = true
		return webView
	}
	
	func updateUIView(_ webView: WKWebView, context: Context) {
		print("Load local file")
		if let url = Bundle.main.url(forResource: "score", withExtension: "html", subdirectory: "www") {
			print("Load local file 2")
			webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
		}
	}

	
	class Coordinator : NSObject, WKNavigationDelegate {
		var parent: WebView
		var delegate: WebViewHandlerDelegate?
		var valueSubscriber: AnyCancellable? = nil
		var loadSubscriber: AnyCancellable? = nil
		var zoomInSubscriber: AnyCancellable? = nil
		var webViewNavigationSubscriber: AnyCancellable? = nil
		
		init(_ uiWebView: WebView) {
			self.parent = uiWebView
			self.delegate = parent
		}
		
		deinit {
			valueSubscriber?.cancel()
			loadSubscriber?.cancel()
			zoomInSubscriber?.cancel()
			webViewNavigationSubscriber?.cancel()
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
			// Get the title of loaded webcontent
			/*webView.evaluateJavaScript("document.title") { (response, error) in
			 if let error = error {
			 print("Error getting title")
			 print(error.localizedDescription)
			 }
			 
			 guard let title = response as? String else {
			 return
			 }
			 
			 self.parent.viewModel.showWebTitle.send(title)
			 }*/
			let javascriptFunction = "load_score_view(\"\(parent.musicXML)\");"
			print(javascriptFunction)
			webView.evaluateJavaScript(javascriptFunction) { (response, error) in
				if let error = error {
					print("Error calling javascript:load_score_view()")
					print(error.localizedDescription)
				} else {
					print("Called javascript:load_score_view()")
				}
			}
			
			/* An observer that observes 'viewModel.valuePublisher' to get value from TextField and
			 pass that value to web app by calling JavaScript function */
			valueSubscriber = parent.viewModel.valuePublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
				let javascriptFunction = "valueGotFromIOS(\"\(value)\");"
				print(javascriptFunction)
				webView.evaluateJavaScript(javascriptFunction) { (response, error) in
					if let error = error {
						print("Error calling javascript:valueGotFromIOS()")
						print(error.localizedDescription)
					} else {
						print("Called javascript:valueGotFromIOS()")
					}
				}
			})
			
			loadSubscriber = parent.viewModel.loadPublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
				let javascriptFunction = "load_score_view(\"\(value)\");"
				print(javascriptFunction)
				webView.evaluateJavaScript(javascriptFunction) { (response, error) in
					if let error = error {
						print("Error calling javascript:load_score_view()")
						print(error.localizedDescription)
					} else {
						print("Called javascript:load_score_view()")
					}
				}
			})
			
			zoomInSubscriber = parent.viewModel.zoomInPublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
				let javascriptFunction = "zoomIn(\"\(value)\");"
				print(javascriptFunction)
				webView.evaluateJavaScript(javascriptFunction) { (response, error) in
					if let error = error {
						print("Error calling javascript:zoomIn()")
						print(error.localizedDescription)
					} else {
						print("Called javascript:zoomIn()")
					}
				}
			})
			
			// Page loaded so no need to show loader anymore
			self.parent.viewModel.showLoader.send(false)
		}
		
		/* Here I implemented most of the WKWebView's delegate functions so that you can know them and
		 can use them in different necessary purposes */
		
		func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
			// Hides loader
			parent.viewModel.showLoader.send(false)
		}
		
		func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
			// Hides loader
			parent.viewModel.showLoader.send(false)
		}
		
		func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
			// Shows loader
			parent.viewModel.showLoader.send(true)
		}
		
		/*func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
			// Shows loader
			parent.viewModel.showLoader.send(true)
			self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
				switch navigation {
				case .backward:
					if webView.canGoBack {
						webView.goBack()
					}
				case .forward:
					if webView.canGoForward {
						webView.goForward()
					}
				case .reload:
					webView.reload()
				}
			})
		}*/
		
		// This function is essential for intercepting every navigation in the webview
		func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
			// Suppose you don't want your user to go a restricted site
			// Here you can get many information about new url from 'navigationAction.request.description'
			if let host = navigationAction.request.url?.host {
				if host == "restricted.com" {
					// This cancels the navigation
					decisionHandler(.cancel)
					return
				}
			}
			// This allows the navigation
			decisionHandler(.allow)
		}
	}
}

// MARK: - Extensions
extension WebView.Coordinator: WKScriptMessageHandler {
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		// Make sure that your passed delegate is called
		if message.name == "iOSNative" {
			if let body = message.body as? [String: Any?] {
				delegate?.receivedJsonValueFromWebView(value: body)
			} else if let body = message.body as? String {
				delegate?.receivedStringValueFromWebView(value: body)
			}
		}
	}
}
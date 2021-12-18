//
//  ScoreViewer.swift
//  ScoreViewer
//
//  Created by Leonore Yardimli on 2021/12/17.
//

import Foundation
import SwiftUI
import WebKit

struct ScoreViewer: UIViewRepresentable {
	var url: URL
	var scoreXML: String
	
	func makeUIView(context: UIViewRepresentableContext<ScoreViewer>) -> WKWebView {
		let preferences = WKPreferences()
		preferences.javaScriptEnabled = true
		
		let configuration = WKWebViewConfiguration()
		configuration.preferences = preferences
		
		let userContentController = WKUserContentController()
		
		userContentController.add(context.coordinator, name:"observer")
		
		configuration.userContentController = userContentController
		
		let webView = WKWebView(frame: .zero, configuration: configuration)
		webView.navigationDelegate = context.coordinator
		
		DispatchQueue.main.async {
			let request = NSURLRequest(url: url)
			webView.load(request as URLRequest)
		}
		return webView
	}
	
	func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<ScoreViewer>) {
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	typealias UIViewType = WKWebView
	
	class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
		
		var control: ScoreViewer
		
		init(_ control: ScoreViewer) {
			self.control = control
		}
		
		func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
			//showAlert(body: message.body)
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
			
			//let name = UIDevice.current.name
			//let systemVersion = UIDevice.current.systemVersion
			
			//let javaScriptString = "device('\(name)', '\(systemVersion)');"
			//webView.evaluateJavaScript(javaScriptString, completionHandler: nil)
			webView.evaluateJavaScript("load_score_view(\"\(control.scoreXML)\");", completionHandler: nil)
		}
		
		/*func showAlert(body: Any) {
		 let content = "\(body)"
		 let alertController = UIAlertController(title: "Trigger", message: content, preferredStyle: .alert)
		 alertController.addAction(UIAlertAction(title: "OK", style: .default))
		 let window = UIApplication.shared.windows.first
		 window?.rootViewController?.present(alertController, animated: true)
		 }*/
		
	}
}




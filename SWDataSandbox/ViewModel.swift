//
//  ViewModel.swift
//  ViewModel
//
//  Created by Leonore Yardimli on 2021/12/18.
//

import Foundation
import Combine
class ViewModel: ObservableObject {
		//var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
		var showWebTitle = PassthroughSubject<String, Never>()
		var showLoader = PassthroughSubject<Bool, Never>()
		var valuePublisher = PassthroughSubject<String, Never>()
		var loadPublisher = PassthroughSubject<String, Never>()
		var zoomInPublisher = PassthroughSubject<String, Never>()
	  var scoreXML = ""
}

// For identifiying WebView's forward and backward navigation
/*enum WebViewNavigation {
		case backward, forward, reload
}*/

// For identifying what type of url should load into WebView
/*enum WebUrlType {
		case localUrl, publicUrl
}*/

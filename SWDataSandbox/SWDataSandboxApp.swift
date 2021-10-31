//
//  SWDataSandboxApp.swift
//  SWDataSandbox
//
//  Created by Leonore Yardimli on 2021/10/23.
//

import SwiftUI

@main
struct SWDataSandboxApp: App {
	@StateObject var navigationGuide = NavigationGuide()
	
	var body: some Scene {
		WindowGroup {
			ContentView().environmentObject(navigationGuide)
		}
	}
}

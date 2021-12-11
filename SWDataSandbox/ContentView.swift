//
//  ContentView.swift
//  SWDataSandbox
//
//  Created by Leonore Yardimli on 2021/10/23.
//

import SwiftUI

struct ContentView: View {
	//let courses = Bundle.main.decode([Course].self, from: "data_scorewind_courses.json")
	@State private var isCurrentView = true
	@EnvironmentObject var navigationGuide:NavigationGuide
	
	var body: some View {
		if isCurrentView == true {
			List {
				ForEach(navigationGuide.courses) { course in
					Button(action: {
						navigationGuide.currentCourse = course
						isCurrentView = false
					}) {
						Text(navigationGuide.replaceCommonHTMLNumber(htmlString: course.title))
							.foregroundColor(Color.black)
					}
				}
			}
		}else{
			CourseView()
		}
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environmentObject(NavigationGuide())
	}
}

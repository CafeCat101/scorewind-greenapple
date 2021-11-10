//
//  LessonView.swift
//  LessonView
//
//  Created by Leonore Yardimli on 2021/10/29.
//

import SwiftUI

struct LessonView: View {
	let screenSize: CGRect = UIScreen.main.bounds
	@State private var showNavigationGuide = false
	@State private var goToView = "lesson"
	@EnvironmentObject var navigationGuide:NavigationGuide
	
	var body: some View {
		if goToView == "lesson"{
			VStack{
				Button(action: {
					showNavigationGuide = true
				}) {
					Text("\(navigationGuide.replaceCommonHTMLNumber(htmlString: navigationGuide.currentLesson.title))")
						.font(.title2)
						.foregroundColor(Color.black)
				}
				Rectangle()
					.frame(height: screenSize.height/2.5)
					.overlay(
						Text("Introduction video")
							.foregroundColor(Color.white))
				//Text(navigationGuide.currentLesson.content)
				HTMLString(htmlContent:navigationGuide.currentLesson.content)
				Spacer()
			}
			.sheet(isPresented: $showNavigationGuide){
				NavigationGuideView(isPresented: self.$showNavigationGuide, setToView: self.$goToView)
			}
		}else{
			if self.goToView == "course"{
				CourseView()
			}else{
				ContentView()
			}
		}
	}
}

struct LessonView_Previews: PreviewProvider {
	static var previews: some View {
		LessonView().environmentObject(NavigationGuide())
	}
}

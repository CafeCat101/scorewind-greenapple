//
//  CourseView.swift
//  CourseView
//
//  Created by Leonore Yardimli on 2021/10/28.
//

import SwiftUI


struct CourseView: View {
	let screenSize: CGRect = UIScreen.main.bounds
	@EnvironmentObject var navigationGuide:NavigationGuide
	@State private var showNavigationGuide = false
	@State private var goToView = "course"
	
	var body: some View {
		if self.goToView == "course"{
			VStack{
				Button(action: {
					showNavigationGuide = true
				}) {
					Text("\(navigationGuide.replaceCommonHTMLNumber(htmlString: navigationGuide.currentCourse.title))")
						.font(.title2)
						.foregroundColor(Color.black)
				}
				Rectangle()
					.frame(height: screenSize.height/2.5)
					.overlay(
						Text("Introduction video")
							.foregroundColor(Color.white))
				/*Text("Introduction")
					.fontWeight(.bold)
				Text(navigationGuide.currentCourse.content)*/
				HTMLString(htmlContent: navigationGuide.removeWhatsNext(Text: navigationGuide.currentCourse.content))
				Spacer()
			}
			.sheet(isPresented: $showNavigationGuide){
				NavigationGuideView(isPresented: self.$showNavigationGuide, setToView: self.$goToView)
			}
			.onAppear(perform: {
				navigationGuide.findPreviousCourse()
				navigationGuide.findNextCourse()
			})
		}else{
			if self.goToView == "lesson"{
				LessonView()
			}else{
				ContentView()
			}
		}
		
	}
}

struct CourseView_Previews: PreviewProvider {
	static var previews: some View {
		CourseView().environmentObject(NavigationGuide())
	}
}

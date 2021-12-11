//
//  NavigationGuideView.swift
//  NavigationGuideView
//
//  Created by Leonore Yardimli on 2021/10/29.
//

import SwiftUI

struct NavigationGuideView: View {
	@Binding var isPresented:Bool
	//var atCourse: Course = Course()
	@Binding var setToView:String
	@EnvironmentObject var navigationGuide:NavigationGuide
	//var atLesson: Lesson = Lesson()
	let screenSize: CGRect = UIScreen.main.bounds
	
	var body: some View {
		VStack{
			List{
				Section(header: Text("Courses")){
					Button(action: {
						navigationGuide.currentLesson = Lesson()
						self.isPresented = false
						self.setToView = "course"
					}) {
						Text("Current course: Introduction")
							.foregroundColor(Color.black)
					}
					
					if navigationGuide.previousCourse.id > 0 {
						Button(action: {
							navigationGuide.currentCourse = navigationGuide.currentCourse
							self.isPresented = false
							self.setToView = "course"
						}) {
							Text("Previous: " + navigationGuide.replaceCommonHTMLNumber(htmlString: navigationGuide.previousCourse.title))
								.foregroundColor(Color.black)
						}
					}
					
					if navigationGuide.nextCourse.id > 0 {
						Button(action: {
							navigationGuide.currentCourse = navigationGuide.nextCourse
							self.isPresented = false
							self.setToView = "course"
						}) {
							Text("Next: " + navigationGuide.replaceCommonHTMLNumber(htmlString: navigationGuide.nextCourse.title))
								.foregroundColor(Color.black)
						}
					}
				}
				
				Section(header: Text("Lessons")){
					ForEach(navigationGuide.currentCourse.lessons){ lesson in
						Button(action: {
							self.isPresented = false
							navigationGuide.currentLesson = lesson
							self.setToView = "lesson"
						}) {
							if navigationGuide.currentLesson.title == lesson.title {
								Text(navigationGuide.replaceCommonHTMLNumber(htmlString: lesson.title))
									.foregroundColor(Color.green)
							}else{
								Text(navigationGuide.replaceCommonHTMLNumber(htmlString: lesson.title))
									.foregroundColor(Color.black)
							}
						}
					}
				}
				
				Section(header: Text("Continue")){
					Button(action: {
						self.isPresented = false
						self.setToView = ""
					}) {
						Text("My courses")
							.foregroundColor(Color.black)
					}
					
					Button(action: {
						//go to use the scorewind wizard. do this later.
					}) {
						Text("Start Scorewind wizard")
							.foregroundColor(Color.black)
					}
				}
				
			}
			
			Spacer()
		}
		.onAppear(perform: {
			navigationGuide.findPreviousCourse()
			navigationGuide.findNextCourse()
		})
	}
}

struct NavigationGuideView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationGuideView(isPresented: .constant(false), setToView: .constant(""))
			.environmentObject(NavigationGuide())
	}
}

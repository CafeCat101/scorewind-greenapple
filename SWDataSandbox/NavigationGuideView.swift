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
				Button(action: {
					self.isPresented = false
					self.setToView = ""
				}) {
					Text("My courses")
						.foregroundColor(Color.black)
				}
				Button(action: {
					self.isPresented = false
					self.setToView = "course"
				}) {
					Text("Current course")
						.foregroundColor(Color.black)
				}
				Section(header: Text("Lessons")){
					ForEach(navigationGuide.currentCourse.lessons){ lesson in
						Button(action: {
							self.isPresented = false
							navigationGuide.currentLesson = lesson
							self.setToView = "lesson"
						}) {
							Text(navigationGuide.replaceCommonHTMLNumber(htmlString: lesson.title))
								.foregroundColor(Color.black)
						}
					}
				}
				
				Section(header: Text("Continue")){
					Button(action: {
						self.isPresented = false
						self.setToView = "course"
					}) {
						Text("Previous course")
							.foregroundColor(Color.black)
					}
					Button(action: {
						self.isPresented = false
						self.setToView = "course"
					}) {
						Text("Next course")
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
	}
}

struct NavigationGuideView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationGuideView(isPresented: .constant(false), setToView: .constant(""))
			.environmentObject(NavigationGuide())
	}
}

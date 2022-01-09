//
//  LessonPartialView2.swift
//  LessonPartialView2
//
//  Created by Leonore Yardimli on 2021/12/16.
//

import SwiftUI

struct LessonPartialView2: View {
	//@Binding var getScoreXML:String
	//let contentURL = Bundle.main.url(forResource: "score", withExtension: "html", subdirectory: "www")
	@EnvironmentObject var navigationGuide:NavigationGuide
    var urlRequest: URLRequest
	var viewModel:ViewModel
	
	var body: some View {
		VStack{
			//ScoreViewer(url: URL(string:"https://google.com")!)
			//ScoreViewer(url:contentURL!, scoreXML:navigationGuide.currentLesson.scoreViewer)
			WebView(viewModel: viewModel)
				/*.onAppear(perform: {
					print(navigationGuide.currentLesson.scoreViewer)
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						viewModel.loadPublisher.send(navigationGuide.currentLesson.scoreViewer)
					}
				})*/
			Button(action: {
				print(navigationGuide.currentLesson.scoreViewer)
				viewModel.loadPublisher.send(navigationGuide.currentLesson.scoreViewer)
			}) {
				Text("Get XML") 
			}
		}
		.onAppear(perform: {
			print("partivalView2 onAppear")
			viewModel.scoreXML = navigationGuide.currentLesson.scoreViewer
		})
	}
}
/*
struct LessonPartialView2_Previews: PreviewProvider {
	static var previews: some View {
		LessonPartialView2(viewModel: ViewModel()).environmentObject(NavigationGuide())
	}
}*/

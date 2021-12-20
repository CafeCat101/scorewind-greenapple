//
//  LessonPartialView2.swift
//  LessonPartialView2
//
//  Created by Leonore Yardimli on 2021/12/16.
//

import SwiftUI

struct LessonPartialView2: View {
	var getScoreXML = ""
	//let contentURL = Bundle.main.url(forResource: "score", withExtension: "html", subdirectory: "www")
	@EnvironmentObject var navigationGuide:NavigationGuide
	@ObservedObject var viewModel = ViewModel()
	
	var body: some View {
		VStack{
			//ScoreViewer(url: URL(string:"https://google.com")!)
			//ScoreViewer(url:contentURL!, scoreXML:navigationGuide.currentLesson.scoreViewer)
			WebView(viewModel: viewModel,musicXML: navigationGuide.currentLesson.scoreViewer)
				/*.onAppear(perform: {
					print(navigationGuide.currentLesson.scoreViewer)
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						viewModel.loadPublisher.send(navigationGuide.currentLesson.scoreViewer)
					}
				})*/
			/*Button(action: {
				print(navigationGuide.currentLesson.scoreViewer)
				viewModel.loadPublisher.send(navigationGuide.currentLesson.scoreViewer)
			}) {
				Text("Get XML") 
			}*/
		}
	}
}

struct LessonPartialView2_Previews: PreviewProvider {
	static var previews: some View {
		LessonPartialView2().environmentObject(NavigationGuide())
	}
}

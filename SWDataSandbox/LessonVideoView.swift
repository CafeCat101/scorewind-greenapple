//
//  LessonVideoView.swift
//  LessonVideoView
//
//  Created by Leonore Yardimli on 2021/12/16.
//

import SwiftUI
import AVKit

struct LessonVideoView: View {
	var getVieoLink = ""
	var viewModel:ViewModel
	@Binding var showScore:Bool
	@EnvironmentObject var navigationGuide:NavigationGuide
	
	var body: some View {
		VStack{
			VideoPlayer(player: AVPlayer(url:URL(string: decodeVideoURL(videoURL: getVieoLink))!))
			Button(action: {
				showScore = true
				print(navigationGuide.currentLesson.scoreViewer)
				viewModel.loadPublisher.send(navigationGuide.currentLesson.scoreViewer)
			}) {
				Text("Score Action Test")
			}
		}
		
	}
	
	private func decodeVideoURL(videoURL:String)->String{
		let decodedURL = videoURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
		//print(decodedURL)
		return decodedURL
	}
}

struct LessonVideoView_Previews: PreviewProvider {
	static var previews: some View {
		LessonVideoView(viewModel: ViewModel(), showScore: .constant(false))
	}
}

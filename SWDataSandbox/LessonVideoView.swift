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
	var body: some View {
		VideoPlayer(player: AVPlayer(url:URL(string: decodeVideoURL(videoURL: getVieoLink))!))
	}
	
	private func decodeVideoURL(videoURL:String)->String{
		let decodedURL = videoURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
		//print(decodedURL)
		return decodedURL
	}
}

struct LessonVideoView_Previews: PreviewProvider {
	static var previews: some View {
		LessonVideoView()
	}
}

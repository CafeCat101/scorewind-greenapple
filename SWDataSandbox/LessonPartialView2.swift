//
//  LessonPartialView2.swift
//  LessonPartialView2
//
//  Created by Leonore Yardimli on 2021/12/16.
//

import SwiftUI

struct LessonPartialView2: View {
	var getScoreXML = ""
	let contentURL = Bundle.main.url(forResource: "score", withExtension: "html", subdirectory: "www")
	
	var body: some View {
		VStack{
			//ScoreViewer(url: URL(string:"https://google.com")!)
			ScoreViewer(url:contentURL!, scoreXML:getScoreXML)
		}
	}
}

struct LessonPartialView2_Previews: PreviewProvider {
	static var previews: some View {
		LessonPartialView2()
	}
}

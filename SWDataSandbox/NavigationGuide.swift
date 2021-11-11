//
//  NavigationGuide.swift
//  NavigationGuide
//
//  Created by Leonore Yardimli on 2021/10/29.
//

import Foundation

class NavigationGuide: ObservableObject{
	@Published var currentCourse = Course()
	@Published var currentLesson = Lesson()
	
	func replaceCommonHTMLNumber(htmlString:String)->String{
		var result = htmlString.replacingOccurrences(of: "&#8211;", with: "-")
		result = result.replacingOccurrences(of: "&#32;", with: " ")
		result = result.replacingOccurrences(of: "&quot;", with: "\"")
		result = result.replacingOccurrences(of: "&#8212;", with: "—")
		result = result.replacingOccurrences(of: "&#8216;", with: "‘")
		result = result.replacingOccurrences(of: "&#8217;", with: "’")
		result = result.replacingOccurrences(of: "&#8220;", with: "“")
		result = result.replacingOccurrences(of: "&#8221;", with: "”")
		return result
	}
	
	//func courseWPToApp(courseContent:String) -> String{
		
	//}
}

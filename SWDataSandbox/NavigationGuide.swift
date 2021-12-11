//
//  NavigationGuide.swift
//  NavigationGuide
//
//  Created by Leonore Yardimli on 2021/10/29.
//

import Foundation
import SwiftUI

class NavigationGuide: ObservableObject{
	@Published var courses = Bundle.main.decode([Course].self, from: "data_scorewind_courses.json")
	@Published var currentCourse = Course()
	@Published var currentLesson = Lesson()
	@Published var previousCourse:Course = Course()
	@Published var nextCourse:Course = Course()
	
	let defineInstrument = "guitar"//"guitar" "violin"
	let defineCourseCategory = "Path" //"Step By Step" "Path"
	var filteredCourses:[Course] = []
	
	init(){
		for course in courses{
			if course.instrument == defineInstrument {
				for getCategory in course.category {
					if getCategory.name == defineCourseCategory {
						filteredCourses.append(course)
						break
					}
				}
			}
		}
		//courses = filteredCourses
		if defineCourseCategory == "Path" {
			courses = filteredCourses.sorted {
				//Int($0.sortValue)! < Int($1.sortValue)!
				let sortOrderArr1 = $0.sortValue.components(separatedBy: "-")
				let sortOrderArr2 = $1.sortValue.components(separatedBy: "-")
				return (Int(sortOrderArr1[0])!, Int(sortOrderArr1[1])!) < (Int(sortOrderArr2[0])!, Int(sortOrderArr2[1])!)
			}
		}else{
			courses = filteredCourses.sorted {
				Int($0.sortValue)! < Int($1.sortValue)!
			}
		}
		
	}
	
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
	
	func removeWhatsNext(Text:String)->String{
		let searchText = "<h4>What's next</h4>"
		if let range: Range<String.Index> = Text.range(of: searchText) {
			let findIndex: Int = Text.distance(from: Text.startIndex, to: range.lowerBound)
			print("index: ", findIndex) //index: 2
			let myText = Text.prefix(findIndex)
			return String(myText)
			//let targetRange = Text.index(after: Text.startIndex)..<findIndex
			
			
		}else{
			return Text
		}
	}
	
	func findPreviousCourse(){
		if currentCourse.id>0 {
			var previousSortOrder = 0
			var sortOrder = currentCourse.sortValue
			print("current sort order " + sortOrder)
			if sortOrder.contains("-") {
				let sortOrderArr = sortOrder.components(separatedBy: "-")
				previousSortOrder = Int(sortOrderArr[1]) ?? 0
				previousSortOrder = previousSortOrder - 1
				sortOrder = String(sortOrderArr[0])+"-"+String(previousSortOrder)
			}else{
				previousSortOrder = Int(sortOrder) ?? 0
				previousSortOrder = previousSortOrder - 1
				sortOrder = String(previousSortOrder)
			}
			print(sortOrder)
			var foundCourse = false
			for course in courses{
				if course.instrument == defineInstrument {
					for getCategory in course.category {
						if getCategory.name == defineCourseCategory {
							if course.sortValue == sortOrder {
								previousCourse = course
								foundCourse = true
								break
							}
						}
					}
				}
			}
			
			if foundCourse == false {
				nextCourse = Course()
			}
			
		}else{
			nextCourse = Course()
		}
	}
	
	func findNextCourse(){
		if currentCourse.id>0 {
			var nextSortOrder = 0
			var sortOrder = currentCourse.sortValue
			print("current sort order " + sortOrder)
			if sortOrder.contains("-") {
				let sortOrderArr = sortOrder.components(separatedBy: "-")
				nextSortOrder = Int(sortOrderArr[1]) ?? 0
				nextSortOrder = nextSortOrder + 1
				sortOrder = String(sortOrderArr[0])+"-"+String(nextSortOrder)
			}else{
				nextSortOrder = Int(sortOrder) ?? 0
				nextSortOrder = nextSortOrder + 1
				sortOrder = String(nextSortOrder)
			}
			print(sortOrder)
			var foundCourse = false
			for course in courses{
				if course.instrument == defineInstrument {
					for getCategory in course.category {
						if getCategory.name == defineCourseCategory {
							if course.sortValue == sortOrder {
								nextCourse = course
								foundCourse = true
								break
							}
						}
					}
				}
			}
			
			if foundCourse == false {
				nextCourse = Course()
			}
			
		}else{
			nextCourse = Course()
		}
	}
	
}

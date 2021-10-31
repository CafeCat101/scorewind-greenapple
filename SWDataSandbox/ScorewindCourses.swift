//
//  ScorewindCourses.swift
//  ScorewindCourses
//
//  Created by Leonore Yardimli on 2021/10/23.
//

import Foundation
import SwiftUI

struct Course: Codable, Identifiable{
	var id: Int
	var title: String
	var content: String
	var image: String
	var tag: [String]
	var category: [CourseCategory]
	var shortDescription: String
	var instrument: String
	var level: String
	var sortValue: Int
	var duration: String
	var lessons: [Lesson]
	
	enum CodingKeys: String, CodingKey{
		case id = "id"
		case title = "course_title"
		case content = "course_content"
		case image = "course_image"
		case tag = "course_tag"
		case category = "course_category"
		case shortDescription = "course_short_description"
		case instrument = "course_instrument"
		case level = "course_level"
		case sortValue = "course_sort_value"
		case duration = "course_duration"
		case lessons = "lessons"
	}
	
	init(){
		id = 0
		title = "Scorewind Course"
		content = "Courses are prepared to focus on a specific subject or technique and they are shaped in a progressive way for the player to get better at a given subject. Want it in a nutshell? In courses you will find unique progressive paths, designed with a step by step approach. They are available for various levels and instruments, and you will have the chance to practice specific techniques or develop stylistic interpretation based on composer."
		image = "course/image"
		tag = ["tag"]
		category = [CourseCategory()]
		shortDescription = ""
		instrument = ""
		level = "beginner"
		sortValue = 1
		duration = "1d"
		lessons = [Lesson()]
		
	}
	
}


struct CourseCategory: Codable, Identifiable{
	var id: Int
	var parent: Int
	var name: String
	
	init(){
		id = 0
		parent = 0
		name = "Main"
	}
}


struct Lesson: Codable, Identifiable{
	var id: Int
	var scorewindID: Int
	var title: String
	var content: String
	var composer: String
	var video: String
	var scoreViewer: String
	var step: Int
	
	enum CodingKeys: String, CodingKey{
		case id = "id"
		case scorewindID = "scorewind_id"
		case title = "lesson_title"
		case content = "lesson_content"
		case composer = "lesson_composer"
		case video = "lesson_video"
		case scoreViewer = "lesson_score_viewer"
		case step = "lesson_step"
	}
	
	init(){
		id = 0
		scorewindID = 0
		title = "Scorewind Lesson"
		content = "Self study music is a joyful journey. It fills your soul, challenges your mind and gives you a path to share your passions. Self study is one of many ways to learn to play music. It’s affordable, and offers flexible studying hours. You can learn at your own pace, and develop your learning path based on your own interests. So, why wait, let’s start playing music!"
		composer = "Scorewind Teacher"
		video = "lesson/video"
		scoreViewer = "lesson/scoreViewer"
		step = 1
	}
}


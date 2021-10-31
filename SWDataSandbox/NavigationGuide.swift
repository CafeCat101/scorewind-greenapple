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
}

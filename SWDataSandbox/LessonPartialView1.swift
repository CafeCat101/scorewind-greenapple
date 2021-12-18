//
//  LessonPartialView1.swift
//  LessonPartialView1
//
//  Created by Leonore Yardimli on 2021/12/16.
//

import SwiftUI

struct LessonPartialView1: View {
	var getHtmlContent = ""
	var body: some View {
		HTMLString(htmlContent:getHtmlContent)
	}
}

struct LessonPartialView1_Previews: PreviewProvider {
    static var previews: some View {
        LessonPartialView1()
    }
}

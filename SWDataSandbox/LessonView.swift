//
//  LessonView.swift
//  LessonView
//
//  Created by Leonore Yardimli on 2021/10/29.
//

import SwiftUI


struct LessonView: View {
	let screenSize: CGRect = UIScreen.main.bounds
	@State private var showScore = false
	@State private var showNavigationGuide = false
	@State private var goToView = "lesson"
	@EnvironmentObject var navigationGuide:NavigationGuide
	@State private var startPos:CGPoint = .zero
	@State private var isSwipping = true
	@ObservedObject var viewModel = ViewModel()
	//@State var getScoreXML = ""
	
	
	var body: some View {
		if goToView == "lesson"{
			VStack{
				Button(action: {
					showNavigationGuide = true
				}) {
					Text("\(navigationGuide.replaceCommonHTMLNumber(htmlString: navigationGuide.currentLesson.title))")
						.font(.title2)
                        .foregroundColor(Color.black)
				}
				
				if navigationGuide.currentLesson.video == "" {
					Rectangle()
						.frame(height: screenSize.height/2.5)
						.overlay(
							Text("Introduction video")
								.foregroundColor(Color.white))
				}else{
					/*VideoPlayer(player: AVPlayer(url:URL(string: decodeVideoURL(videoURL: navigationGuide.currentLesson.video))!))
						.frame(height: screenSize.height/2.5)*/
					LessonVideoView(getVieoLink: navigationGuide.currentLesson.video, viewModel: viewModel, showScore: $showScore)
						.frame(height: screenSize.height/2.5)
				}
				
				/*Rectangle()
					.frame(height: screenSize.height/2.5)
					.overlay(
						Text("Introduction video")
							.foregroundColor(Color.white))*/
				//Text(navigationGuide.currentLesson.content)
				VStack{
					if showScore == false {
						LessonPartialView1(getHtmlContent: navigationGuide.currentLesson.content)
					}else {
                        LessonPartialView2(urlRequest:getScoreURLRequest(scoreXML: navigationGuide.currentLesson.scoreViewer),viewModel: viewModel)
					}
				}
				.gesture(
					DragGesture()
						.onChanged { gesture in
							if self.isSwipping {
								self.startPos = gesture.location
								self.isSwipping.toggle()
							}
						}
						.onEnded { gesture in
							let xDist =  abs(gesture.location.x - self.startPos.x)
							let yDist =  abs(gesture.location.y - self.startPos.y)
							if self.startPos.y <  gesture.location.y && yDist > xDist {
								//down
							}
							else if self.startPos.y >  gesture.location.y && yDist > xDist {
								//up
							}
							else if self.startPos.x > gesture.location.x && yDist < xDist {
								//left
								withAnimation{
									showScore = true
								}
							}
							else if self.startPos.x < gesture.location.x && yDist < xDist {
								//right
								withAnimation{
									showScore = false
								}
							}
							self.isSwipping.toggle()
						}
				)
				
				
				Spacer()
			}
			.sheet(isPresented: $showNavigationGuide, onDismiss: {
				//showScore = false
				viewModel.scoreXML = navigationGuide.currentLesson.scoreViewer
                print("ondismiss sheet")
			}){
				NavigationGuideView(isPresented: self.$showNavigationGuide, setToView: self.$goToView)
			}
			.onAppear(perform: {
				print(navigationGuide.currentLesson.video)
			})
		}else{
			if self.goToView == "course"{
				CourseView()
			}else{
				ContentView()
			}
		}
	}
	
	private func decodeVideoURL(videoURL:String)->String{
		let decodedURL = videoURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
		print(decodedURL)
		return decodedURL
	}
    private func getScoreURLRequest(scoreXML:String)->URLRequest{
        let decodedXML = scoreXML.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let url = Bundle.main.url(forResource: "score", withExtension: "html", subdirectory: "www")
        let fullUrl = URL(string: "?score="+decodedXML, relativeTo: url);
        let request = URLRequest(url:fullUrl!)
        print("getScoreURLRequest "+decodedXML)
        return request
    }
}

struct LessonView_Previews: PreviewProvider {
	static var previews: some View {
		LessonView().environmentObject(NavigationGuide())
	}
}

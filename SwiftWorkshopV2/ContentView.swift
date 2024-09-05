//
//  ContentView.swift
//  SwiftWorkshopV2
//
//  Created by Paul Frank on 15/02/24.
//

import SwiftUI

struct ContentView: View {
	
	@State var isActive = false
	
    var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundStyle(.tint)
			Text("Hello, world!")
				.fontWeight(isActive ? .bold : .light)
				.font(isActive ? .system(size: 32) : .system(size: 16))
//				.onAppear(perform: {
//					withAnimation {
//						isActive.toggle()
//					}
//				})
			Button(action: {
				withAnimation {
					isActive.toggle()
				}
			}, label: {
				Text("Change state")
			})
			.buttonStyle(.bordered)
		}
        .padding()
    }
}

struct CircleLoading: View {
	
	@State var appear = false
	
	var body: some View {
			Text("Hola Mundo")
			.encapsuledText()
			
	}
}

struct RoundedTextCapsule: ViewModifier {
	func body(content: Content) -> some View {
		VStack {
			content
				.font(.system(size: 32, design: .rounded))
				.fontWeight(.bold)
				.foregroundStyle(.green)
				.padding()
				.overlay {
					Rectangle()
						.stroke(lineWidth: 5)
						.cornerRadius(3.0)
				}
		}
	}
}

extension View {
	func encapsuledText() -> some View {
		modifier(RoundedTextCapsule())
	}
}


struct TextMoving: View {
	
	@Namespace var namespace
	@State var show = false
	
	@State var photoSelected: String = ""
	
	let columns = [GridItem(.flexible()), GridItem(.flexible())]
	
	var photoList: [String] = ["https://images.pexels.com/photos/12801441/pexels-photo-12801441.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/16129759/pexels-photo-16129759/free-photo-of-a-laptop-and-a-coffee-on-a-table-in-starbucks-cafe.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/7133627/pexels-photo-7133627.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/6922916/pexels-photo-6922916.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/12505401/pexels-photo-12505401.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/5327394/pexels-photo-5327394.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/7436817/pexels-photo-7436817.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/18092314/pexels-photo-18092314/free-photo-of-a-line-to-starbucks.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
							   "https://images.pexels.com/photos/16111012/pexels-photo-16111012/free-photo-of-empty-chairs-and-tables-in-front-of-a-starbucks.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"]
	
	
	var body: some View {
		ZStack {
			if !show {
				ScrollView(.vertical) {
					LazyVGrid(columns: columns, content: {
						ForEach(photoList, id: \.self) { photoUrl in
							PhotoItem(photoUrl:photoUrl)
								.matchedGeometryEffect(id: photoUrl, in: namespace)
								.onTapGesture {
									withAnimation {
										photoSelected = photoUrl
										show.toggle()
									}
								}
						}
					})
				}
			} else {
				PhotoItem(photoUrl: photoSelected)
					.matchedGeometryEffect(id: photoSelected, in: namespace)
					.onTapGesture {
						withAnimation {
							show.toggle()
						} completion: {
							photoSelected = ""
						}

					}

			}
		}
	}
}

struct PhotoItem: View {
	var photoUrl: String = ""
	
	var body: some View {
		AsyncImage(url: URL(string: photoUrl)) { image in
			image
				.resizable()
				.scaledToFill()
				.clipped()
				
		} placeholder: {
			ProgressView()
		}
	}
}

#Preview {
    //ContentView()
	CircleLoading()
	//TextMoving()
}

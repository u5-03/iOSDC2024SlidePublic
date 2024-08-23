//
//  ContentView.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/06/16.
//

import SwiftUI
import SlideKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            IntroductionSlide()
                .background(Color.red)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text("Hello, world!")
                .font(.system(size: 100))
                .background(Color.red)
            Spacer(minLength: 0)
        }
        .background(Color.purple)
    }
}

#Preview {
    ContentView()
}

@Slide
struct IntroductionSlide: View {
    var body: some View {
        HeaderSlide("SlideKit") {
            Item("SlideKit helps you make presentation slides by SwiftUI")
            Item("The followings are provided") {
                Item("Views", accessory: .number(2))
                Item("Structures")
                Item("Utilities")
            }
            .background(Color.blue)
        }
        .headerSlideStyle(CustomHeaderSlideStyle())
        .background(Color.green)
    }
}

struct CustomHeaderStyleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            IntroductionSlide()
        }
    }
}

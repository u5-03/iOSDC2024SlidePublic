//
//  OneMoreThingSlide.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/05.
//

import SwiftUI
import SlideKit

@Slide
struct OneMoreThingSlide: View {

    var body: some View {
        VStack {
            Spacer()
            LinearGradient(
                colors: [
                    .white,
                    .gray
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 180)
            .mask {
                Text("One more thing...")
                    .font(.system(size: 160, weight: .bold))
            }
            Spacer()
        }
        .background(Color.black)
    }
}

#Preview {
    SlidePreview {
        OneMoreThingSlide()
    }
    .headerSlideStyle(CustomHeaderSlideStyle())
    .itemStyle(CustomItemStyle())
}

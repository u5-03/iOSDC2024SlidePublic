//
//  PianoImageCompareSlide.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/06.
//

import SwiftUI
import SlideKit
import PianoUI

@Slide
struct PianoImageCompareSlide: View {
    var body: some View {
        HeaderSlide("実物と実装したUIの比較") {
            HStack(spacing: 20) {
                VStack(alignment: .center, spacing: 30) {
                    Image(.fourthOctavePiano)
                        .resizable()
                    PianoView(pianoStrokes: [])
                        .frame(height: 320)
                }
                PianoView(pianoStrokes: [])
                    .frame(width: 200)
            }
        }
    }
}

#Preview {
    SlidePreview {
        PianoImageCompareSlide()
    }
    .headerSlideStyle(CustomHeaderSlideStyle())
    .itemStyle(CustomItemStyle())
}

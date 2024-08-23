//
//  SlideBaseView.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/12.
//

import SwiftUI
import SlideKit

struct SlideBaseView: View {
    static let configuration = SlideConfiguration()
    @State private var didOpenBook = false
    let autoScrollViewHeight: CGFloat = 80

    var presentationContentView: some View {
        SlideRouterView(slideIndexController: Self.configuration.slideIndexController)
            .slideTheme(Self.configuration.theme)
            .foregroundColor(.black)
            .background(.white)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                if !didOpenBook {
                    BookView {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            didOpenBook = true
                        }
                    }
                }
                if didOpenBook {
                    ZStack {
                        PresentationView(slideSize: Self.configuration.size) {
                            presentationContentView
                        }
                        HStack(spacing: 0) {
                            Rectangle()
                                .foregroundStyle(Color.black.opacity(0.01))
                                .onTapGesture {
                                    Self.configuration.slideIndexController.back()
                                }
                            Color.clear
                                .containerRelativeFrame(.horizontal) { length, _ in
                                    return length * 0.8
                                }
                            Rectangle()
                                .foregroundStyle(Color.black.opacity(0.01))
                                .onTapGesture {
                                    Self.configuration.slideIndexController.forward()
                                }
                        }
                    }
                }
            }
            .containerRelativeFrame(.vertical, { length, _ in
                return length - autoScrollViewHeight
            })
            .background(.black)
            .clipped()
            SlideBottomView()
                .frame(alignment: .leading)
        }
    }
}

#Preview {
    SlideBaseView()
        .frame(width: 800, height: 450)
}

//
//  CenterText.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/01.
//

import SwiftUI
import SlideKit

@Slide
struct CenterText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeFont)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.defaultForegroundColor)
            .background(.slideBackgroundColor)

    }
}

#Preview {
    SlidePreview {
        CenterText(text: "CenterText")
    }
}

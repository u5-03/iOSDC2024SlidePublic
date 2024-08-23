//
//  SlideBottomView.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/02.
//

import SwiftUI

struct SlideBottomView: View {
    private let autoScrollController = AutoScrollController(message: introductionSentence, duration: .seconds(300))

    var body: some View {
        AutoScrollTextView(controller: autoScrollController)
    }
}

#Preview {
    SlideBottomView()
}

//
//  AutoScrollTextView.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/07/27.
//

import SwiftUI
import Foundation
import Observation
import Algorithms

#if os(macOS)
import AppKit
public typealias AppFont = NSFont
public typealias AppColor = NSColor
#elseif os(iOS)
import UIKit
public typealias AppFont = UIFont
public typealias AppColor = UIColor
#endif

public struct AutoScrollTextView: View {
    // Making the controller optional allows you to place the MarqueeView before text is available to display without crashing your app.
    @State var controller: AutoScrollController

    public init(controller: AutoScrollController) {
        self.controller = controller
    }

    public var body: some View {
        HStack(spacing: 0) {
            Group {
                if let formatRemainingTime = controller.formatRemainingTime {
                    Text(formatRemainingTime)
                        .font(.system(size: 30, weight: .bold))
                        .minimumScaleFactor(0.1)
                        .frame(width: 60)
                } else {
                    Button(action: {
                        controller.startScrolling()
                    }, label: {
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(4)
                    })
                }
            }
            .padding()
            // なぜかGeometryReaderがないと、レイアウトが大きく崩れる
            GeometryReader { gr in
                TimelineView(.animation) { context in
                    let progress = controller.progress(currentData: context.date)
                    return AutoScrollLayout(progress: progress) {
                        ForEach(controller.splittedMessage, id: \.self) { message in
                            Text(message)
                                .font(Font(controller.marqueeFont))
                                .foregroundStyle(.primary)
                        }
                    }
                }
                .clipped()
            }
        }
    }
}

fileprivate struct AutoScrollLayout: Layout {
    fileprivate let progress: CGFloat // Range: 0 ~ 1

fileprivate struct Cache {
    var widths: [CGFloat]
    var startPoints: [CGFloat]
    var totolWidth: CGFloat
}

fileprivate func makeCache(subviews: Subviews) -> Cache {
    var startPoint: CGFloat = 0
    var startPoints: [CGFloat] = []
    var widths: [CGFloat] = []
    subviews.forEach { subView in
        let width = subView.sizeThatFits(.unspecified).width
        startPoints.append(startPoint)
        startPoint += width
        widths.append(width)
    }
    return Cache(widths: widths, startPoints: startPoints, totolWidth: startPoint)
}

    fileprivate func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        return .init(
            width: proposal.replacingUnspecifiedDimensions().width + cache.totolWidth,
            height: proposal.replacingUnspecifiedDimensions().height
        )
    }

    fileprivate func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        for (index, subView) in subviews.indexed() {
            // サブビューが表示範囲内にある場合のみ配置
            let startPoint = cache.startPoints[index]
            let textWidth = cache.widths[index]
            let endPoint = startPoint + textWidth
            let totalWidth = cache.totolWidth
            let displayWidth = proposal.width ?? 0
            // displayWidth * 1.5表示場所をずらす
            let beginingEmptyWidth = displayWidth * 1.5
            let displayStartPoint = (totalWidth + beginingEmptyWidth) * progress
            let displayEndPoint = displayStartPoint + displayWidth
            if startPoint > displayEndPoint {
                break
            } else if displayStartPoint <= endPoint || startPoint + displayWidth <= displayEndPoint {
                subView.place(
                    at: CGPoint(x: bounds.minX + startPoint - displayStartPoint + beginingEmptyWidth, y: bounds.midY),
                    anchor: .leading,
                    proposal: .init(
                        width: textWidth,
                        height: proposal.height ?? 0
                    )
                )
            }
        }
    }
}

@Observable
public final class AutoScrollController {
    fileprivate var startTime: Double?
    fileprivate var progress: Double?
    fileprivate let speed = 100.0 // points/second
    // Using a AppFont because the width can be measured.
    public let marqueeFont: AppFont
    fileprivate var splittedMessage: [String] = []
    private let messageUnit = 50
    private let message: String
    private let duration: Duration

    public var formatRemainingTime: String? {
        guard let progress else { return nil }
        let remainingTime = max(0, Double(duration.components.seconds) * (1.0 - progress))
        // 残り時間を分と秒に変換
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60

        // m:ss形式にフォーマット
        return String(format: "%d:%02d", minutes, seconds)
    }

    public init(message: String, duration: Duration, marqueeFont: AppFont = AppFont.systemFont(ofSize: 40, weight: .bold)) {
        self.message = message
        self.duration = duration
        self.marqueeFont = marqueeFont
    }

    fileprivate func progress(currentData: Date) -> CGFloat {
        guard let startTime else { return 0 }
        let progress = (Double(currentData.timeIntervalSince1970) - startTime) / Double(duration.components.seconds)
        self.progress = progress
        return progress
    }

    public func startScrolling() {
        splittedMessage = message.removingNewlines.splitStringIntoChunks(chunkSize: messageUnit)
        startTime = Date().timeIntervalSince1970
    }
}

fileprivate extension String {
    var removingNewlines: String {
        return self.components(separatedBy: .newlines).joined()
    }

    func width(usingFont font: AppFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: attributes).width
    }

    func splitStringIntoChunks(chunkSize: Int) -> [String] {
        var chunks: [String] = []
        var currentIndex = startIndex

        while currentIndex < endIndex {
            let endIndex = index(currentIndex, offsetBy: chunkSize, limitedBy: endIndex) ?? endIndex
            let chunk = String(self[currentIndex..<endIndex])
            chunks.append(chunk)
            currentIndex = endIndex
        }
        return chunks
    }
}

#Preview {
    let controller = AutoScrollController(message: introductionSentence, duration: Duration.seconds(300))
    return HStack {
        AutoScrollTextView(controller: controller)
            .frame(height: 80, alignment: .leading)
            .onAppear {
//                controller.startScrolling()
            }
    }
}


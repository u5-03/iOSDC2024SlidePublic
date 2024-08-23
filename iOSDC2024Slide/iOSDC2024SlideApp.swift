//
//  iOSDC2024SlideApp.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/06/16.
//

import SwiftUI
import SlideKit

@main
struct iOSDC2024SlideApp: App {
    //    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @Environment(\.openWindow) var openWindow

    var body: some Scene {
#if os(macOS)
        WindowGroup {
            SlideBaseView()
        }
        .setupAsPresentationWindow(SlideBaseView.configuration.slideIndexController) {
            openWindow(id: "presenter")
        }
//        .addPDFExportCommands(for: presentationContentView, with: Self.configuration.slideIndexController, size: Self.configuration.size)

//        WindowGroup(id: "presenter") {
//            VStack {
//                macOSPresenterView(
//                    slideSize: Self.configuration.size,
//                    slideIndexController: Self.configuration.slideIndexController
//                ) {
//                    presentationContentView
//                }
//            }
//        }
//        .setupAsPresenterWindow()
#elseif os(iOS)
        WindowGroup {
            SlideBaseView()
        }
#endif
    }
}

struct SlideConfiguration {

    /// Edit the slide size.
    let size = SlideSize.standard16_9

    ///  「ある日」の分のスライドはスキップする
    let slideIndexController = SlideIndexController(index: 1) {
        CenterText(text: .init(localized: "someday", defaultValue: "ある日..."))
        TitleImageSlide()
        CenterText(text: .init(localized: "degital_piano", defaultValue: "電子ピアノ"))
        CenterText(text: .init(localized: "degitalPianoEqualGadget", defaultValue: "電子ピアノ=ガジェット"))
        CenterText(text: .init(localized: "iWantToPlay", defaultValue: "なので何か使って遊びたい！"))
        TitleSlide()
        CenterText(text: .init(localized: "implementationAppOfPianoWithStroke", defaultValue: "今回はピアノの鍵盤を叩く強さを\n表示できるアプリを実装しました"))
        OsTitleSlide(shouldAnimated: false)
        CenterText(text: .init(localized: "pianoWithMidi", defaultValue: "我が家の電子ピアノはMIDIの\n規格に対応している"))
        MidiSlide()
        PianoStrokeInfoSlide()
        PianoStrokeConstructionSlide()
        ConnectionChartSlide()
        PianoImageCompareSlide()
        PianoViewStructureSlide()
        CenterText(text: .init(localized: "playDemoVideo", defaultValue: "デモ動画を流します"))
        CenterText(text: .init(localized: "byTheWay", defaultValue: "ちなみに..."))
        AppendixSlide()
        CenterText(text: .init(localized: "connectWirelessDevice", defaultValue: "有線を繋げないデバイスでも利用できる！"))
        OneMoreThingSlide()
        OsTitleSlide(shouldAnimated: true)
        CenterText(text: .init(localized: "playVisionProDemoVideo", defaultValue: "Vision Proでのデモ動画を流します!"))
        VideoSlide(videoName: "opening_input", fileExtension: "mp4")
        ImageSlide(imageName: "ipadAppCapture")
        VideoSlide(videoName: "opening_output", fileExtension: "mp4")
        WrapupSlide()
        ReadmeSlide()
        ReferenceSlide()
        EndSlide()
    }

    let theme = CustomSlideTheme()
}

struct CustomSlideTheme: SlideTheme {
    let headerSlideStyle = CustomHeaderSlideStyle()
    let itemStyle = CustomItemStyle()
    let indexStyle = CustomIndexStyle()
}

struct CustomIndexStyle: IndexStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text("\(configuration.slideIndexController.currentIndex + 1) / \(configuration.slideIndexController.slides.count)")
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .font(.system(size: 30))
            .padding()
    }
}

//
//struct SlideKitDemo_macOSApp: App {
//
//    @Environment(\.openWindow) var openWindow
//
//    /// Edit slide configurations in SlideConfiguration.swift
//    private static let configuration = SlideConfiguration()
//
//    /// A presentation content view.
//    /// Edit the view if you'd like to set environment, overlay view or background view here.
//    var presentationContentView: some View {
//        SlideRouterView(slideIndexController: Self.configuration.slideIndexController)
//            .slideTheme(Self.configuration.theme)
//            .foregroundColor(.black) // Edit this color if you want to use another color for text color.
//            .background(.white)
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            PresentationView(slideSize: Self.configuration.size) {
//                presentationContentView
//            }
//        }
//        .setupAsPresentationWindow(Self.configuration.slideIndexController) {
//            openWindow(id: "presenter")
//        }
//        .addPDFExportCommands(for: presentationContentView, with: Self.configuration.slideIndexController, size: Self.configuration.size)
//
//        WindowGroup(id: "presenter") {
//            macOSPresenterView(
//                slideSize: Self.configuration.size,
//                slideIndexController: Self.configuration.slideIndexController
//            ) {
//                presentationContentView
//            }
//        }
//        .setupAsPresenterWindow()
//    }
//}


//
//  introductionSentence.swift
//  iOSDC2024Slide
//
//  Created by Yugo Sugiyama on 2024/08/01.
//

import Foundation

let introductionSentence = String(localized: "introductionSentence", defaultValue: """
始まりました🎉。iOSDCのLT！時間がないので、自己紹介と補足情報はこちらで流します(読まなくても大丈夫です笑)。
名前はすぎー、現在はDeNAでFlutter製のスポーツ系のライブ配信 play-by-sportsの開発をしています(果敢にライブ配信アプリをFlutterで作っています笑)。
エンジニアと人生コミュニティにも所属しています
↑さきほどのピアノ🎹はClavinova CVP-905というYAMAHAの電子ピアノです。
この電子ピアノは追加のアダプターを購入すれば、BluetoothでのMIDI通信も実現できます。
↑今回実装したアプリはピアノを弾く自分のパートナーが、ピアノの音の強さを定量的に確認できる方法がなく、それを確認できるアプリがほしい！と言われたので、作ることになったアプリです笑。
趣味は料理したり、アニメみたり、家庭菜園したりです。
去年の発表で使ったパイナップル🍎もスクスク成長中です！
魚・和食・和菓子が好きなので、たい焼きのアイコンにしました！
家にたい焼き器もあります笑。
CoreMIDIで最初は全て実装しましたが、UI側まで実装するのはかなり大変だったので、途中でUIもサポートされてるMIDIKitに切り替えました。
↑ドレミファソラシは、英語だとCDEFGABなので、enumのcase名は英語で定義しています。
ちなみに日本語のドレミファソラシは、イタリア語のDo, Re, Mi, Fa, Sol, La, Siをローマ字読みしたものです。
このスライドは@mtj_jさん🦌のSlideKitを使ったSwiftUI製です。
冒頭の楽譜風の本を開くアニメーションや、この電光掲示板風のUIは今回の発表のために作った自作の機能で、UIFont/NSFont以外はすべてSwiftUI製です。
なおこのスライドはPDFで共有できないので、後ほどTestFlightで共有します。iOS📱とmacOS💻で確認できて、本文は英語のLocalizeも対応済です。
ちなみにこのスライド用にXcode CloudでのCI・CDも整備して、ビルドとTestFlightへの配布は自動化済みです笑。
スライドに載ってない情報は参考資料を確認いただけると。
発表内容や資料のフィードバック・質問等は、LT後やXでのメンションなどでもらえると助かります！
あと明後日8/26(月)にLINEヤフー株式会社・株式会社ディー・エヌ・エー共催の振り返りイベント「After iOSDC Japan 2024」をDeNA渋谷本社で実施するので、
そこに参加する方はぜひiOSDC2024の勢いのままワイワイしながら、お話ししましょう！
↑ちなみにデモ動画の曲はiPhoneのアラームのサウンド>クラシック>オープニングという曲です！
そろそろLTが終わりの時間だ。もうすぐiOSDC2024も終わりですが、#iwillblogするまでがiOSDC2024です！残りのiOSDC2024も全力で楽しみましょう🥳
"""
)

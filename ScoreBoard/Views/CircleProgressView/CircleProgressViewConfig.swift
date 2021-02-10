//
//  CircleProgressViewConfig.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 30/01/2021.
//

import SwiftUI

struct CircleProgressViewConfig {
    let outerCircleWidth: CGFloat
    let outerCircleColor: Color
    let colors: [UIColor]
    let progressBarWidth: CGFloat
    let progressBarSpacing: CGFloat
}

extension CircleProgressViewConfig {
    static let defaultConfig = CircleProgressViewConfig(outerCircleWidth: 2,
                                                        outerCircleColor: .black,
                                                        colors: [.orange, .yellow, .green, .purple],
                                                        progressBarWidth: 5,
                                                        progressBarSpacing: 10)
}

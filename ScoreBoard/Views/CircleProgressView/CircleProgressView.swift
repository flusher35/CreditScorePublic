//
//  CircleProgressView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 30/01/2021.
//

import SwiftUI

struct CircleProgressView: View {

    /// Set progress indicator from 0.0 to 1.0 (0-100%)
    var progress: CGFloat
    /// Set progress animation duration
    var animationDuration: Double
    let config: CircleProgressViewConfig

    private var colors: [Color] {
        return config.colors.map { Color($0) }
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: config.outerCircleWidth)
                .foregroundColor(config.outerCircleColor)
            AngularGradient(gradient: Gradient(colors: colors), center: .center, startAngle: .zero, endAngle: .degrees(355))
                .mask(
            Circle()
                .trim(from: 0, to: min(progress, 1))
                .stroke(style: StrokeStyle(lineWidth: config.progressBarWidth, lineCap: .round, lineJoin: .round))
                .animation(.easeOut(duration: animationDuration))
                .padding(config.progressBarSpacing)
            )
        }
        .rotationEffect(Angle(degrees: 270))
        .padding(config.outerCircleWidth / 2)
    }
}

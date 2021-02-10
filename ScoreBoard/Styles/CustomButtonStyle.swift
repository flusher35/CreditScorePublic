//
//  CustomButtonStyle.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 03/02/2021.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {

    let config: CustomButtonStyleConfig

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(config.titleColor)
            .font(.system(size: 17, weight: .semibold))
            .animation(nil)
            .lineLimit(1)
            .padding(.horizontal, 16)
            .frame(height: 42)
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? config.backgroundPressedColor : config.backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(configuration.isPressed ? config.borderPressedColor : config.borderColor, lineWidth: 3)
                )
            .shadow(color: Color.black.opacity(0.35), radius: 8, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut)
    }
}

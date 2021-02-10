//
//  CustomButtonStyleConfig.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 03/02/2021.
//

import SwiftUI

enum CustomButtonStyleConfig {
    case primary
    case secondary

    // MARK: - Internal computed properties
    var backgroundColor: Color? {
        switch self {
        case .primary: return .black
        case .secondary: return Color.black.opacity(0.01)
        }
    }

    var backgroundPressedColor: Color? {
        switch self {
        case .primary: return .gray
        case .secondary: return Color.black.opacity(0.01)
        }
    }

    var borderColor: Color {
        switch self {
        case .primary: return .black
        case .secondary: return .black
        }
    }

    var borderPressedColor: Color {
        switch self {
        case .primary: return .gray
        case .secondary: return .gray
        }
    }

    var titleColor: Color {
        switch self {
        case .primary: return .white
        case .secondary: return .black
        }
    }
}

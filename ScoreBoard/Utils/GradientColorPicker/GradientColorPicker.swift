//
//  GradientColorPicker.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 01/02/2021.
//

import UIKit

class GradientColorPicker {
    // MARK: - Private stored properties
    private let colors: [CGColor]
    private let precision: CGFloat // greater value gives more precision
    private lazy var gradient = CGGradient(colorsSpace: nil,
                                           colors: colors as CFArray,
                                           locations: nil)
    private lazy var context: CGContext? = {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        return context
    }()
    private var pixel: [CUnsignedChar] = [0,0,0,0]
    private var previousValue: CGFloat = 0

    // MARK: - Internal methods
    init(colors: [UIColor], precision: CGFloat = 1000) {
        self.colors = colors.map { $0.cgColor }
        self.precision = precision
    }

    /// Get color from gradient in a range by percentage 0.0 - 1.0 (0-100%)
    func getUIColor(percentage: CGFloat) -> UIColor? {
        guard let gradient = gradient, let context = context else { return nil }
        let translation = percentage * precision
        context.translateBy(x: previousValue - translation, y: 0)
        previousValue = translation
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: precision, y: 0), options: [])
        return UIColor(red: CGFloat(pixel[0])/255.0,
                       green: CGFloat(pixel[1])/255.0,
                       blue: CGFloat(pixel[2])/255.0,
                       alpha: CGFloat(pixel[3])/255.0)
    }
}

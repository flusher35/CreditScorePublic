//
//  CounterLabelView.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 01/02/2021.
//

import SwiftUI

struct CounterLabelView: View {
    // MARK: - Private stored properties
    private var number: Int
    private var increment: Int
    private weak var colorProvider: ColorForNumberProvider?
    @State private var currentNumber: Int = 0

    init(number: Int, increment: Int, colorProvider: ColorForNumberProvider? = nil) {
        self.number = number
        self.increment = increment
        self.colorProvider = colorProvider
    }

    var body: some View {
        Text(String(currentNumber))
            .foregroundColor(Color(colorProvider?.getColor(for: currentNumber) ?? .black))
            .animation(nil)
            .onFrame(onFrameUpdate)
    }

    // MARK: - Private methods
    private func onFrameUpdate(frame: DisplayLink.Frame) {
        guard currentNumber != number else { return }
        if currentNumber < number {
            currentNumber = min(currentNumber + increment, number)
        } else if currentNumber > number {
            currentNumber = max(currentNumber - increment, number)
        }
    }
}

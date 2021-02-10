//
//  CircleProgressViewTests.swift
//  ScoreBoardUITests
//
//  Created by Anton Shevtsov on 09/02/2021.
//

@testable import ScoreBoard
import XCTest

class CircleProgressViewTests: XCTestCase {
    private let record = false

    func testNoProgress() {
        CircleProgressView(progress: 0, animationDuration: 0, config: .defaultConfig)
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }

    func testHalfProgress() {
        CircleProgressView(progress: 0.5, animationDuration: 0, config: .defaultConfig)
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }

    func test9ClockProgress() {
        CircleProgressView(progress: 0.75, animationDuration: 0, config: .defaultConfig)
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }

    func testFullProgress() {
        CircleProgressView(progress: 1, animationDuration: 0, config: .defaultConfig)
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }
}

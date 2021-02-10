//
//  ActivityIndicatorViewTests.swift
//  ScoreBoardUITests
//
//  Created by Anton Shevtsov on 09/02/2021.
//

@testable import ScoreBoard
import XCTest

class ActivityIndicatorViewTests: XCTestCase {
    private let record = false

    func testSimple() {
        ActivityIndicatorView()
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }
}

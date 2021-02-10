//
//  ErrorModalViewTests.swift
//  ScoreBoardUITests
//
//  Created by Anton Shevtsov on 09/02/2021.
//

@testable import ScoreBoard
import XCTest

class ErrorModalViewTests: XCTestCase {
    private let record = false

    func testShortTexts() {
        let viewModel = ErrorModalViewModel(text: "Here is some text", retryButtonText: "RETRY")
        ErrorModalView(viewModel: viewModel)
            .padding()
            .test(size: CGSize(width: 325, height: 200), record: record)
    }

    func testLongTexts() {
        let viewModel = ErrorModalViewModel(text: "This is a very very very long title that should not be there but still is very possible to come up in case of very long error text", retryButtonText: "RETRY AND KEEP TRYING")
        ErrorModalView(viewModel: viewModel)
            .padding()
            .test(size: CGSize(width: 325, height: 350), record: record)
    }
}

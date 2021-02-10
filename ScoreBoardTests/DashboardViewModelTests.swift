//
//  DashboardViewModelTests.swift
//  ScoreBoardTests
//
//  Created by Anton Shevtsov on 03/02/2021.
//

import Combine
import XCTest

class DashboardViewModelTests: XCTestCase {

    var cancellableBag = Set<AnyCancellable>()
    let creditReportInteractorMock = CreditReportInteractorMock()

    func testGetCreditReportOnLaunch() {
        // given app was launched
        let viewModel = DashboardViewModel(interactor: creditReportInteractorMock)
        let requestExpectation = expectation(description: #function)
        creditReportInteractorMock.didCallGetCreditReportInfo = { requestExpectation.fulfill() }
        // when dashboard appears
        viewModel.viewDidAppear()
        // then request for credit info is made
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testGetCreditReportLoadingState() {
        // given app was launched
        let viewModel = DashboardViewModel(interactor: creditReportInteractorMock)
        let expectedLoadingPattern = [false, true, false]
        var loadingPattern = [Bool]()
        creditReportInteractorMock.didCallGetCreditReportInfo = {
            loadingPattern.append(viewModel.isLoading)
        }
        // when dashboard appears
        loadingPattern.append(viewModel.isLoading)
        viewModel.viewDidAppear()
        DispatchQueue.main.async {
            loadingPattern.append(viewModel.isLoading)
            // then request is made and loading state sequence is correct
            XCTAssertEqual(expectedLoadingPattern, loadingPattern)
        }
    }

    func testGetCreditReportData() {
        // given app was launched
        let viewModel = DashboardViewModel(interactor: creditReportInteractorMock)
        let responseStub = CreditReportResponseStub.response2
        creditReportInteractorMock.stub = responseStub
        let loadDataExpectation = expectation(description: #function)
        var receivedScore: Int?
        var receivedMaxScore: Int?
        var isScoreDetailsVisible = false
        viewModel.$progress
            .dropFirst()
            .sink { _ in
                receivedScore = viewModel.currentScore
                receivedMaxScore = viewModel.maxScore
                isScoreDetailsVisible = viewModel.isScoreDetailsVisible
                loadDataExpectation.fulfill()
            }
            .store(in: &cancellableBag)
        // when dashboard appears
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 0.3, handler: nil)
        // then request is made and data is loaded
        XCTAssertTrue(isScoreDetailsVisible, "score details should be visible after getting data")
        XCTAssertEqual(receivedMaxScore, responseStub.creditReportInfo.maxScoreValue, "received max score is incorrect")
        XCTAssertEqual(receivedScore, responseStub.creditReportInfo.score, "received current score is incorrect")
    }

    func testGetCreditReportError() {
        // given app was launched
        let viewModel = DashboardViewModel(interactor: creditReportInteractorMock)
        let errorStub = CreditReportInteractorError.networkError(.invalidStatus)
        creditReportInteractorMock.errorStub = errorStub
        let errorExpectation = expectation(description: #function)
        viewModel.$isModalPresented
            .dropFirst()
            .sink { _ in
                if case .error = viewModel.modalType {
                    errorExpectation.fulfill()
                } else {
                    XCTFail("error modal was not presented")
                }
            }
            .store(in: &cancellableBag)
        XCTAssertNil(viewModel.modalType, "there should be no modal presented")
        // when dashboard appears
        viewModel.viewDidAppear()
        // then request is made and error modal is presented upon received error
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

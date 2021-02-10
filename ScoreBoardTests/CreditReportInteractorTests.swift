//
//  CreditReportInteractorTests.swift
//  ScoreBoardTests
//
//  Created by Anton Shevtsov on 03/02/2021.
//

import XCTest

class CreditReportInteractorTests: XCTestCase {

    let networkManagerMock = NetworkManagerMock<CreditReportResponse>()
    lazy var creditReportInteractor = CreditReportInteractor(apiSettings: APISettings(), networkManager: networkManagerMock)

    func testGetCreditReport() {
        // given expected response to receive
        let expectedResponse = CreditReportResponseStub.response3
        networkManagerMock.stub = expectedResponse
        let responseExpectation = expectation(description: #function)
        var receivedResponse: CreditReportResponse?
        // when making request for credit info
        creditReportInteractor.getCreditReportInfo { response in
            switch response {
            case .success(let response):
                receivedResponse = response
                responseExpectation.fulfill()
            case .failure(_): XCTFail()
            }
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        // then expected response is received
        XCTAssertEqual(receivedResponse, expectedResponse)
    }

    func testGetError() {
        // given expected network error to receive
        networkManagerMock.errorStub = .invalidStatus
        let responseExpectation = expectation(description: #function)
        let expectedError = CreditReportInteractorError.networkError(.invalidStatus)
        var receivedError: CreditReportInteractorError?
        // when making request for credit info
        creditReportInteractor.getCreditReportInfo { response in
            switch response {
            case .success(_): XCTFail()
            case .failure(let error):
                receivedError = error
                responseExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        // then expected interactor error is received
        XCTAssertEqual(receivedError, expectedError)
    }
}

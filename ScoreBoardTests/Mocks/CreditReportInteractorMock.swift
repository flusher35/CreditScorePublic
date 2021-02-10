//
//  CreditReportInteractorMock.swift
//  ScoreBoardTests
//
//  Created by Anton Shevtsov on 06/02/2021.
//

class CreditReportInteractorMock: CreditReportInteracting {

    var stub: CreditReportResponse?
    var errorStub: CreditReportInteractorError?
    var didCallGetCreditReportInfo: CompletionClosure?

    func getCreditReportInfo(completion: @escaping CompletionValueClosure<Result<CreditReportResponse, CreditReportInteractorError>>) {
        didCallGetCreditReportInfo?()
        if let stub = stub {
            completion(.success(stub))
        } else {
            completion(.failure(errorStub ?? .invalidURL))
        }
    }
}

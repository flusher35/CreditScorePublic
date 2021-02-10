//
//  CreditReportInteractorError.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

enum CreditReportInteractorError: Error, Equatable {
    case networkError(NetworkError)
    case invalidURL

    var shortDescription: String {
        switch self {
        case .networkError(let error): return error.shortDescription
        case .invalidURL: return "Invalid request URL"
        }
    }
}

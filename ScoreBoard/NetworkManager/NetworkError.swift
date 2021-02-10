//
//  NetworkError.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import Foundation

enum NetworkError: Error, Equatable {
    case dataNotReceived
    case invalidStatus
    case decodeError(String?)
    case session(NSError)

    var shortDescription: String {
        switch self {
        case .dataNotReceived: return "Data not received"
        case .invalidStatus: return "Invalid response status"
        case .decodeError(let description): return description ?? "Response decode error"
        case .session(let error): return error.localizedDescription
        }
    }
}

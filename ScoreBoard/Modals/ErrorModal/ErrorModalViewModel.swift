//
//  ErrorModalViewModel.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 02/02/2021.
//

import Combine

class ErrorModalViewModel: ObservableObject {
    // MARK: - Internal stored properties
    let text: String
    let retryButtonText: String
    let actionSubject = PassthroughSubject<Void, Never>()

    // MARK: - Internal methods
    init(text: String,
         retryButtonText: String) {
        self.text = text
        self.retryButtonText = retryButtonText
    }

    deinit {
        actionSubject.send(completion: .finished)
    }
}

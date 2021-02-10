//
//  DashboardViewModelModalFactory.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 02/02/2021.
//

protocol DashboardViewModelModalFactoryProviding {
    func createErrorModalViewModel(text: String) -> ErrorModalViewModel
}

class DashboardViewModelModalFactory: DashboardViewModelModalFactoryProviding {
    func createErrorModalViewModel(text: String) -> ErrorModalViewModel {
        return ErrorModalViewModel(text: text,
                                   retryButtonText: Strings.retry.uppercased())
    }
}

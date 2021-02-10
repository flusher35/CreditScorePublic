//
//  ScoreInteractor.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import Foundation

protocol CreditReportInteracting: AnyObject {
    func getCreditReportInfo(completion: @escaping CompletionValueClosure<Result<CreditReportResponse, CreditReportInteractorError>>)
}

class CreditReportInteractor: CreditReportInteracting {

    // MARK: - Private stored properties
    private let apiSettings: APISettingsProvider
    private var networkManager: NetworkManagerInterface

    // MARK: - Internal methods
    init(apiSettings: APISettingsProvider = APISettings(),
         networkManager: NetworkManagerInterface = NetworkManager()) {
        self.apiSettings = apiSettings
        self.networkManager = networkManager
    }

    func getCreditReportInfo(completion: @escaping CompletionValueClosure<Result<CreditReportResponse, CreditReportInteractorError>>) {
        guard let url = constructURL() else {
            completion(.failure(.invalidURL))
            return
        }
        networkManager.getDataFrom(url: url) { (result: Result<CreditReportResponse, NetworkError>) in
            switch result {
            case .failure(let error): completion(.failure(.networkError(error)))
            case .success(let report): completion(.success(report))
            }
        }
    }

    // MARK: - Private methods
    private func constructURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiSettings.apiHost
        components.path = apiSettings.apiPath
        components.queryItems = []
        return components.url
    }
}

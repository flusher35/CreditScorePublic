//
//  NetworkManager.swift
//  ScoreBoard
//
//  Created by Anton Shevtsov on 31/01/2021.
//

import Foundation

protocol NetworkManagerInterface {
    func getDataFrom<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager: NetworkManagerInterface {

    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 7
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration)
        return session
    }()

    // MARK: - Internal methods
    func getDataFrom<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.session(error as NSError)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidStatus))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataNotReceived))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodeError(self?.createDecodeError(from: error))))
            }
        }
        .resume()
    }

    // MARK: - Private methods
    private func createDecodeError(from error: Error) -> String {
        switch error {
        case DecodingError.keyNotFound(let key, let context): return "could not find key \(key) in JSON: \(context.debugDescription)"
        case DecodingError.valueNotFound(let type, let context): return "could not find type \(type) in JSON: \(context.debugDescription)"
        case DecodingError.typeMismatch(let type, let context): return "type mismatch for type \(type) in JSON: \(context.debugDescription)"
        case DecodingError.dataCorrupted(let context): return "data found to be corrupted in JSON: \(context.debugDescription)"
        default: return "Unknown error \(error.localizedDescription)"
        }
    }
}

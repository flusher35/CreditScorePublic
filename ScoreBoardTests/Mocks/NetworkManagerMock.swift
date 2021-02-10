//
//  NetworkManagerMock.swift
//  ScoreBoardTests
//
//  Created by Anton Shevtsov on 03/02/2021.
//

import Foundation

class NetworkManagerMock<T: Decodable>: NetworkManagerInterface {

    var stub: T?
    var errorStub: NetworkError?

    func getDataFrom<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if let stub = stub {
            completion(.success(stub as! T))
        } else {
            completion(.failure(errorStub ?? .dataNotReceived))
        }
    }
}

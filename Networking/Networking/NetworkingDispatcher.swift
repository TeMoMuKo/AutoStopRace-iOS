//
//  NetworkingDispatcher.swift
//  Networking
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public class NetworkingDispatcher {

    let baseURL: String
    private let sessionConfiguration = URLSessionConfiguration.default
    private lazy var session = URLSession(configuration: sessionConfiguration)
    private var token: String?

    private enum Config {
        static let headerTokenField = "x-auth-token"
        static let baseURL = "BaseURL"
    }

    public init() {
        guard let baseURL = Bundle.info(for: Config.baseURL), !baseURL.isEmpty else {
            fatalError("Networking: Missing base url")
        }
        self.baseURL = baseURL
    }

    public func process<T: Decodable>(request: NetworkingRequest, completion: @escaping (Result<T, Error>) -> Void) {

        guard let request = request.standardURLRequest(with: baseURL, token: token) else {
            completion(.failure(NetworkingError.badURL))
            return
        }

        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
                self.token == nil {
                if let headerTokenField = response.allHeaderFields[Config.headerTokenField] as? String {
                    print(headerTokenField)
                    self.token = headerTokenField
                }
            }

            if let data = data {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

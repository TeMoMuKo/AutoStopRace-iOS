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

    private let tokenStorageProvider = TokenStorageProvider()

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

        guard let request = request.standardURLRequest(with: baseURL, token: tokenStorageProvider.fetchToken()) else {
            completion(.failure(NetworkingError.badURL))
            return
        }

        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return
            }

            if let error = self.checkResponseForErrors(response) {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
                self.tokenStorageProvider.fetchToken() == nil {
                if let headerTokenField = response.allHeaderFields[Config.headerTokenField] as? String {
                    self.tokenStorageProvider.store(token: headerTokenField)
                }
            }

            if let data = data {
                do {
                    print("💚 \(String(decoding: data, as: UTF8.self))")
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch let error {
                    print("❌ Networking error: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func checkResponseForErrors(_ response: URLResponse?) -> Error? {
        guard let httpResponse = response as? HTTPURLResponse,
            let statusCode = HttpStatus(rawValue: httpResponse.statusCode) else { return nil }
        switch statusCode {
        case .badRequest:
            return NetworkingError.badRequest
        case .unauthorized:
            return NetworkingError.unauthorized
        case .forbidden:
            return NetworkingError.forbidden
        case .notFound:
            return NetworkingError.notFound
        case .internalServerError:
            return NetworkingError.internalServerError
        case .badGateway:
            return NetworkingError.badGateway
        default:
            return nil
        }
    }
}

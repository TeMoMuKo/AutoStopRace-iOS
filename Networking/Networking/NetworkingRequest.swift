//
//  NetworkingRequest.swift
//  Networking
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

public class NetworkingRequest {
    let path: String
    let method: RequestMethod
    var headers: [String: String]?
    var httpBody: Data?

    private enum Config {
        static let headerTokenField = "x-auth-token"
    }

    init(path: String, method: RequestMethod, headers: [String: String]? = nil, httpBody: Data? = nil ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.httpBody = httpBody
    }

    public func standardURLRequest(with baseURL: String, token: String? ) -> URLRequest? {

        guard let url = URL(string: "\(baseURL)\(path)") else { return nil }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        if let httpBody = httpBody {
            urlRequest.httpBody = httpBody
        }

        if let token = token {
            urlRequest.addValue(token, forHTTPHeaderField: Config.headerTokenField)
        }

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }
}

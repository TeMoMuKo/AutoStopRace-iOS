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
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)

    private enum ConfigKeys {
        static let baseURL = "BaseURL"
    }

    public init() {
        guard let baseURL = Bundle.info(for: ConfigKeys.baseURL), !baseURL.isEmpty else {
            fatalError("Networking: Missing base url")
        }
        self.baseURL = baseURL
    }
}

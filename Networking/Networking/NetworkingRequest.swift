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

    init(path: String, method: RequestMethod) {
        self.path = path
        self.method = method
    }
}

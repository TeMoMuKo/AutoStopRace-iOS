//
//  HttpStatus.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public enum HttpStatus: Int {
    case ok = 200
    case created = 201

    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unprocessableEntity = 422

    case internalServerError = 500
    case badGateway = 502

    public var isSuccess: Bool {
        return self.rawValue >= 200 && self.rawValue <= 299
    }

    public var isClientError: Bool {
        return self.rawValue >= 400 && self.rawValue <= 499
    }

    public var isServerError: Bool {
        return self.rawValue >= 500 && self.rawValue <= 599
    }
}

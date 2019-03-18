//
//  HttpStatus.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public enum HttpStatus: Int {
    case OK = 200
    case Created = 201

    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case UnprocessableEntity = 422

    case InternalServerError = 500
    case BadGateway = 502

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

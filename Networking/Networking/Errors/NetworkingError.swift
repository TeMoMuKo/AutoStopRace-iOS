//
//  NetworkingErrors.swift
//  Networking
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case badURL
    case invalidJson
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("error_400", comment: "")
        case .unauthorized:
            return NSLocalizedString("error_401", comment: "")
        case .forbidden:
            return NSLocalizedString("error_403", comment: "")
        case .notFound:
            return NSLocalizedString("error_404", comment: "")
        case .internalServerError:
            return NSLocalizedString("error_500", comment: "")
        case .badGateway:
            return NSLocalizedString("error_502", comment: "")
        default:
            return NSLocalizedString("error_404", comment: "")
        }
    }
}

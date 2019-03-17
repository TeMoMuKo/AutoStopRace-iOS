//
//  AsrApi.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Moya
import Alamofire

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

struct JsonDictionaryEncoding: Moya.ParameterEncoding {
    public static var `default`: JsonDictionaryEncoding { return JsonDictionaryEncoding() }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        let json = try JSONSerialization.data(withJSONObject: parameters!, options: [.prettyPrinted])
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = json
        return req
    }
    
}

enum AsrApi {
    case singIn(email: String, password: String)
    case signOut
    case validateToken
    case resetPassword(email: String, redirectUrl: String)
    case postNewLocation(location: CreateLocationRecordRequest)
    case userLocations(String)
    case allTeams
    case team(String)
}

extension AsrApi: TargetType {
    var baseURL: URL { return URL(string: ApiConfig.baseURL)! }
    
    var path: String {
        switch self {
        case .singIn:
            return "auth/sign_in"
        case .signOut:
            return "auth/sign_out"
        case .validateToken:
            return "auth/validate_token"
        case .resetPassword:
            return "auth/password"
        case .postNewLocation:
            return "locations"
        case .userLocations(let slug):
            return "teams/\(slug)/locations"
        case .allTeams:
            return "teams"
        case .team(let slug):
            return "teams/\(slug)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateToken, .userLocations, .allTeams, .team:
            return .get
        case .signOut:
            return .delete
        case .singIn, .postNewLocation, .resetPassword:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .signOut, .validateToken, .singIn, .postNewLocation, .userLocations, .resetPassword, .allTeams, .team:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .signOut, .validateToken, .allTeams, .team, .userLocations:
            return .requestPlain
        case .singIn(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding:  JSONEncoding.default)
        case .resetPassword(let email, let redirectUrl):
            return .requestParameters(parameters: ["email": email, "redirect_url": redirectUrl], encoding: JSONEncoding.default)
        case .postNewLocation(let location):
            return .requestParameters(parameters: location.toDictionary(), encoding: JsonDictionaryEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

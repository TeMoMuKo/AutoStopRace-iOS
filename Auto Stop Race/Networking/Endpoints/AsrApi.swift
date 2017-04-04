//
//  AsrApi.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Moya
import Alamofire

enum AsrApi {
    case singIn(email: String, password: String)
    case validateToken
    case postNewLocation(location: CreateLocationRecordRequest)
    case userLocations(String)
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

extension AsrApi: TargetType {
    
    var baseURL: URL { return URL(string: ApiConfig.baseURL)! }
    
    var path: String {
        switch self {
        case .singIn(_,_):
            return "/api/v2/auth/sign_in"
        case .validateToken:
            return "/api/v2/auth/validate_token"
        case .postNewLocation(_):
            return "/api/v2/locations"
        case .userLocations(let slug):
            return "/api/v2/teams/\(slug)/locations"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateToken, .userLocations(_):
            return .get
        case .singIn, .postNewLocation:
            return .post
        }
    }
        
    var parameters: [String: Any]? {
        switch self {
        case .validateToken, .userLocations(_):
            return nil
        case .singIn(let email, let password):
            return ["email": email, "password": password]
        case .postNewLocation(let location):
            return location.toDictionary()
        }
    }
    

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .postNewLocation:
            return JsonDictionaryEncoding.default
        case .validateToken:
            return URLEncoding.default
        case .singIn, .userLocations(_):
            return JSONEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .validateToken, .singIn, .postNewLocation, .userLocations(_):
            return "".utf8Encoded
        }
    }
    
    var task:Task {
        switch self {
        case .singIn, .validateToken, .postNewLocation, .userLocations(_):
            return .request
        }
    }
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

//
//  AsrApi.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Moya
import Alamofire

public enum HttpStatus: Int{
    case OK = 200
    case Created = 201
    
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    
    case InternalServerError = 500
    case BadGateway = 502
    
    public var isSuccess:Bool{
        return self.rawValue >= 200 && self.rawValue <= 299
    }
    
    public var isClientError:Bool{
        return self.rawValue >= 400 && self.rawValue <= 499
    }
    
    public var isServerError:Bool{
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
}

extension AsrApi: TargetType {
    
    var baseURL: URL { return URL(string: ApiConfig.baseURL)! }
    
    var path: String {
        switch self {
        case .singIn(_,_):
            return "auth/sign_in"
        case .signOut:
            return "auth/sign_out"
        case .validateToken:
            return "auth/validate_token"
        case .resetPassword:
            return "auth/password"
        case .postNewLocation(_):
            return "locations"
        case .userLocations(let slug):
            return "teams/\(slug)/locations"
            
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateToken, .userLocations(_):
            return .get
        case .signOut:
            return .delete
        case .singIn, .postNewLocation, .resetPassword:
            return .post
        }
    }
        
    var parameters: [String: Any]? {
        switch self {
        case .signOut, .validateToken, .userLocations(_):
            return nil
        case .singIn(let email, let password):
            return ["email": email, "password": password]
        case .resetPassword(let email, let redirectUrl):
            return ["email": email, "redirect_url": redirectUrl]
        case .postNewLocation(let location):
            return location.toDictionary()
        }
    }
    

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .postNewLocation:
            return JsonDictionaryEncoding.default
        case .signOut, .validateToken:
            return URLEncoding.default
        case .singIn, .userLocations(_), .resetPassword:
            return JSONEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .signOut, .validateToken, .singIn, .postNewLocation, .userLocations(_), .resetPassword:
            return "".utf8Encoded
        }
    }
    
    var task:Task {
        switch self {
        case .signOut, .singIn, .validateToken, .postNewLocation, .userLocations(_), .resetPassword:
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

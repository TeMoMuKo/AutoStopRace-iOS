//
//  AsrApi.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Moya

enum AsrApi {
    case singIn(email: String, password: String)
}

extension AsrApi: TargetType {


    var baseURL: URL { return URL(string: ApiConfig.baseURL)! }
    
    var path: String {
        switch self {
        case .singIn(_,_):
            return "/api/v2/auth/sign_in"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .singIn:
            return .post
        }
    }
        
    var parameters: [String: Any]? {
        switch self {
        case .singIn(let email, let password):
            return ["email": email, "password": password]
        }
    }
        
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .singIn:
            return JSONEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .singIn:
            return "".utf8Encoded
        }
    }
    
    var task:Task {
        switch self {
        case .singIn:
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

//
//  UsersService.swift
//  Networking
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public final class ApiService: ApiServiceType {

    let networkingDispatcher: NetworkingDispatcher

    public init(networkingDispatcher: NetworkingDispatcher) {
        self.networkingDispatcher = networkingDispatcher
    }

    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let credentialsString = "\(email):\(password)"
        let base64EncodedCredentials = Data(credentialsString.utf8).base64EncodedString()
        
        let userNetworkingRequest = NetworkingRequest(path: "/user",
                                                      method: .get,
                                                      headers: ["Authorization": "Basic \(base64EncodedCredentials)"])

        networkingDispatcher.process(request: userNetworkingRequest, completion: { result in
            completion(result)
        })
    }

    public func fetchTeams(completion: @escaping (Result<[Team], Error>) -> Void) {
        let teamsNetworkingRequest = NetworkingRequest(path: "/teams",
                                                      method: .get)
        networkingDispatcher.process(request: teamsNetworkingRequest, completion: { result in
            completion(result)
        })
    }

    public func fetchLocations(for teamNumber: Int, completion: @escaping (Result<[LocationRecord], Error>) -> Void) {
        let locationsNetworkingRequest = NetworkingRequest(path: "/teams/\(teamNumber)/locations",
                                                       method: .get)
        networkingDispatcher.process(request: locationsNetworkingRequest, completion: { result in
            completion(result)
        })
    }
}

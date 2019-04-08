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
    let multipartFormDataUtils: MultipartFormDataUtils

    public init(networkingDispatcher: NetworkingDispatcher, multipartFormDataUtils: MultipartFormDataUtils) {
        self.networkingDispatcher = networkingDispatcher
        self.multipartFormDataUtils = multipartFormDataUtils
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

    public func fetchUserLocations(completion: @escaping (Result<[LocationRecord], Error>) -> Void) {
        let userLocationsNetworkingRequest = NetworkingRequest(path: "/user/team/locations",
                                                               method: .get)
        networkingDispatcher.process(request: userLocationsNetworkingRequest, completion: { result in
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

    public func postNewLocation(createLocationModel: CreateLocationRecordRequest, locationImage: LocationImage?, completion: @escaping (Result<LocationRecord, Error>) -> Void) {
        let boundary = multipartFormDataUtils.generateBoundary()

        guard let jsonData = try? JSONEncoder().encode(createLocationModel),
            let jsonString = String(data: jsonData, encoding: .utf8) else {
                completion(.failure(NetworkingError.invalidJson))
                return
        }

        let parameters: [String: String] = [
            "locationData": jsonString
        ]

        let postNewLocationRequestData = multipartFormDataUtils.createDataBody(withParameters: parameters, image: locationImage, boundary: boundary)

        let postNewLocation = NetworkingRequest(path: "/locations",
                                                method: .post,
                                                headers: ["Content-Type":"multipart/form-data; boundary=\(boundary)"],
                                                httpBody: postNewLocationRequestData)
        
        networkingDispatcher.process(request: postNewLocation, completion: { result in
            completion(result)
        })
    }
}

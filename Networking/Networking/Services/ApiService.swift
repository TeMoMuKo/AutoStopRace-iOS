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

    public func postNewLocation(completion: @escaping (Result<LocationRecord, Error>) -> Void) {
        let boundary = generateBoundary()

        let locationData = #"""
            {
                "latitude": 13.12318321,
                "longitude": 24.1233424,
                "message": "Send from iOS"
            }
            """#

        let parameters: [String: String] = [
            "locationData": locationData
        ]

        let postNewLocationRequestData = createDataBody(withParameters: parameters, image: nil, boundary: boundary)

        let postNewLocation = NetworkingRequest(path: "/locations",
                                                method: .post,
                                                headers: ["Content-Type":"multipart/form-data; boundary=\(boundary)"],
                                                httpBody: postNewLocationRequestData)
        networkingDispatcher.process(request: postNewLocation, completion: { result in
            completion(result)
        })
    }

    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func createDataBody(withParameters params: [String: String]?, image: LocationImage?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()

        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }

        if let image = image {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(image.filename)\"\(lineBreak)")
            body.append("Content-Type: \(image.mimeType + lineBreak + lineBreak)")
            body.append(image.data)
            body.append(lineBreak)
        }

        body.append("--\(boundary)--\(lineBreak)")

        return body
    }
}

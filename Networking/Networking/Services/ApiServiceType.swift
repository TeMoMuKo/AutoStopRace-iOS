//
//  AuthenticationServiceType.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public protocol ApiServiceType {

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func fetchTeams(completion: @escaping (Result<[Team], Error>) -> Void)
    func fetchLocations(completion: @escaping (Result<[LocationRecord], Error>) -> Void)
}

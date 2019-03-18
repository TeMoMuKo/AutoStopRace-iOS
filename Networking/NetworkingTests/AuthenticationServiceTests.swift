//
//  AuthenticationServiceTests.swift
//  NetworkingTests
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

@testable import Networking
import Quick
import Nimble

class ApiServiceTests: QuickSpec {

    override func spec() {

        describe("ApiService") {

            var sut: ApiService!

            beforeEach {
                sut = ApiService(networkingDispatcher: NetworkingDispatcher())
            }

            describe("when performing authentication with valid credentials") {
                it("should return valid response") {
                    waitUntil { done in
                        sut.signIn(email: "user1@example.com", password: "qweasdzxc") { result in
                            print(result)
                            done()
                        }
                    }
                }
            }
        }
    }
}

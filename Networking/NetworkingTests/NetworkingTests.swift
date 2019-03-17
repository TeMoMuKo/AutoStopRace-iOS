//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

@testable import Networking

import Quick
import Nimble

class NetworkingTests: QuickSpec {

    override func spec() {

        describe("NetworkingDispatcher") {

            var sut: NetworkingDispatcher!

            beforeEach {
                sut = NetworkingDispatcher()
            }

            context("after being instantiated") {

                it("should have base url") {
                    expect(sut.baseURL).toNot(beNil())
                }
            }
        }
    }
}

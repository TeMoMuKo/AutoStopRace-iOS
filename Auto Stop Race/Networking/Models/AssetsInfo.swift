//
//  AssetsInfo.swift
//  Auto Stop Race
//
//  Created by RI on 26/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import Foundation

struct AssetsInfo: Codable {
    let schedule, campusMap: String

    enum CodingKeys: String, CodingKey {
        case schedule
        case campusMap = "campus_map"
    }
}

extension AssetsInfo {
    init(data: Data) throws {
        self = try JSONDecoder().decode(AssetsInfo.self, from: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
}

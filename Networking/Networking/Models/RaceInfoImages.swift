//
//  AssetsInfo.swift
//  Auto Stop Race
//
//  Created by RI on 26/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import Foundation

public struct RaceInfoImages: Codable {
    let campusMapImageUrl, scheduleImageUrl: String

    enum CodingKeys: String, CodingKey {
        case campusMapImageUrl
        case scheduleImageUrl
    }
}

extension RaceInfoImages {
    init(data: Data) throws {
        self = try JSONDecoder().decode(RaceInfoImages.self, from: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
}

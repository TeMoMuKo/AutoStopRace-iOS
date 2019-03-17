//
//  Bundle+Extension.swift
//  Networking
//
//  Created by RI on 17/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

extension Bundle {

    private enum Constants {
        static let customConfigKey = "Custom config"
    }

    static func info(for key: String) -> String? {
        guard let customConfig = Bundle(for: NetworkingDispatcher.self).infoDictionary?[Constants.customConfigKey] as? [String: String] else { return nil }
        return customConfig[key]
    }
}

//
//  MultipartDataProvider.swift
//  Networking
//
//  Created by RI on 08/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public final class MultipartFormDataUtils {

    public init() { }
    
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

//
//  CLLocationCoordinate2D.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 29.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    var latitudeMinutes:  Double { return (latitude * 3600).truncatingRemainder(dividingBy: 3600) / 60 }
    var latitudeSeconds:  Double { return ((latitude * 3600).truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60) }
    
    var longitudeMinutes: Double { return (longitude * 3600).truncatingRemainder(dividingBy: 3600) / 60 }
    var longitudeSeconds: Double { return ((longitude * 3600).truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60) }
    
    var dms:(latitude: String, longitude: String) {
        
        return (String(format:"%d° %d' %d\" %@",
                       Int(abs(latitude)),
                       Int(abs(latitudeMinutes)),
                       Int(abs(latitudeSeconds)),
                       latitude >= 0 ? "N" : "S"),
                String(format:"%d° %d' %d\" %@",
                       Int(abs(longitude)),
                       Int(abs(longitudeMinutes)),
                       Int(abs(longitudeSeconds)),
                       longitude >= 0 ? "E" : "W"))
    }
}

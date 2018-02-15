//
//  RealmDatabase.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 10.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmDatabaseServiceType {
    func clearDatabase()
    func addUnsentLocationRecord(locationRecord: CreateLocationRecordRequest)
    func getUnsentLocationRecords() -> [CreateLocationRecordRequest]
    func removeLocationRecord(locationRecord: CreateLocationRecordRequest)
    func saveRemoteLocationsToLocalDatabase(locationRecord: LocationRecord)
    func getLocationRecords() -> [LocationRecord]
}

final class RealmDatabaseService: BaseService, RealmDatabaseServiceType {
    let realm = try! Realm()

    func clearDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func addUnsentLocationRecord(locationRecord: CreateLocationRecordRequest) {
        try! realm.write {
            realm.add(locationRecord)
        }
    }
    
    func getUnsentLocationRecords() -> [CreateLocationRecordRequest] {
        return Array(realm.objects(CreateLocationRecordRequest.self))
    }

    func removeLocationRecord(locationRecord: CreateLocationRecordRequest){
        try! realm.write {
            realm.delete(locationRecord)
        }
    }
    
    func saveRemoteLocationsToLocalDatabase(locationRecord: LocationRecord) {
        try! realm.write {
            let locationThatExists = realm.objects(LocationRecord.self).filter("id == %@", locationRecord.id).first
            if locationThatExists == nil {
                let localLocationRecord = LocationRecord(value: locationRecord)
                realm.add(localLocationRecord)
            }
        }
    }
    
    func getLocationRecords() -> [LocationRecord] {
        var remoteLocations = Array(realm.objects(LocationRecord.self).sorted(byKeyPath: "created_at", ascending: false))
        let unsendLocations = Array(realm.objects(CreateLocationRecordRequest.self))
        for unsendLocation in unsendLocations {
            let locationRecord = LocationRecord()
            locationRecord.latitude = unsendLocation.latitude
            locationRecord.longitude = unsendLocation.longitude
            locationRecord.message = unsendLocation.message
            remoteLocations.insert(locationRecord, at: remoteLocations.startIndex)
        }
        return remoteLocations
    }
}

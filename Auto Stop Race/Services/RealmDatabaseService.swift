//
//  RealmDatabase.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 10.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RealmSwift
import Networking

protocol RealmDatabaseServiceType {
    func clearDatabase()
    func addUnsentLocationRecord(locationRecord: CreateLocationRecordRequest)
    func getUnsentLocationRecords() -> [CreateLocationRecordRequest]
    func removeLocationRecord(locationRecord: CreateLocationRecordRequest)
    func saveRemoteLocationsToLocalDatabase(locationRecord: LocationRecord)
    func getLocationRecords() -> [LocationRecord]
}

final class RealmDatabaseService: BaseService, RealmDatabaseServiceType {

    func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            return try action(realm)
        } catch let error {
            return nil
            //fatalError("Failed \(operation) realm with error: \(error)")
        }
    }

    func clearDatabase() {
        _ = withRealm("Clear database") { realm in
            try realm.write {
                realm.deleteAll()
            }
        }
    }
    
    func addUnsentLocationRecord(locationRecord: CreateLocationRecordRequest) {
        _ = withRealm("Add unsend location record") { realm in
            try realm.write {
                realm.add(locationRecord)
            }
        }
    }
    
    func getUnsentLocationRecords() -> [CreateLocationRecordRequest] {
        let unsentLocationRecords = withRealm("Remove location record") { realm -> [CreateLocationRecordRequest] in
            Array(realm.objects(CreateLocationRecordRequest.self))
        }
        return unsentLocationRecords ?? []
    }

    func removeLocationRecord(locationRecord: CreateLocationRecordRequest) {
        _ = withRealm("Remove location record") { realm in
            try realm.write {
                realm.delete(locationRecord)
            }
        }
    }
    
    func saveRemoteLocationsToLocalDatabase(locationRecord: LocationRecord) {
        _ = withRealm("Save remote locations to local database") { realm in
            try realm.write {
                let locationThatExists = realm.objects(LocationRecord.self).filter("id == %@", locationRecord.id).first
                if locationThatExists == nil {
                   // let localLocationRecord = KwasLocationRecord(value: locationRecord)
                   // realm.add(localLocationRecord)
                }
            }
        }
    }
    
    func getLocationRecords() -> [LocationRecord] {
        let remoteLocations = withRealm("Save remote locations to local database") { realm -> [LocationRecord] in
            var remoteLocations = Array(realm.objects(LocationRecord.self).sorted(byKeyPath: "created_at", ascending: false))
            let unsendLocations = Array(realm.objects(CreateLocationRecordRequest.self))
//            for unsendLocation in unsendLocations {
//                let locationRecord = KwasLocationRecord()
//                locationRecord.latitude = unsendLocation.latitude
//                locationRecord.longitude = unsendLocation.longitude
//                locationRecord.message = unsendLocation.message
//                remoteLocations.insert(locationRecord, at: remoteLocations.startIndex)
//            }
            return remoteLocations
        }
        return remoteLocations ?? []
    }
}

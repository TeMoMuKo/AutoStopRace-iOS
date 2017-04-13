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
}

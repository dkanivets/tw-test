//
//  RLMProject.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import RealmSwift

class RLMProject: Object {
    @objc dynamic var projectDescr: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var defaultPrivacy: String = ""
    @objc dynamic var createdOn: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var logo: String = ""
    @objc dynamic var endDate: String = ""
    @objc dynamic var startDate: String = ""
    
    func write() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

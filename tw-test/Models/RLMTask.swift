//
//  RLMTask.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import RealmSwift

class RLMTask: Object {
    @objc dynamic var taskDescr: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var taskListID: String = ""
    
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

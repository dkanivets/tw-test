//
//  RLMTasksList.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

//
//  RLMProject.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import RealmSwift

class RLMTasksList: Object {
//    "name": "General tasks",
//    "pinned": false,
//    "milestone-id": "",
//    "description": "",
//    "uncompleted-count": 90,
//    "id": "958199",
//    "complete": false,
//    "private": false,
//    "isTemplate": false,
//    "position": 1001,
//    "status": "reopened",
//    "projectId": "301444",
//    "projectName": "Cool Project 5",
//    "DLM": null
    
    @objc dynamic var tasksListDescr: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var projectID: String = ""
    
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


//
//  TasksViewModel.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift

class TasksViewModel {
    let taskList: RLMTasksList
    var items: [RLMTask] {
        let realm = try! Realm()
        let items = Array(realm.objects(RLMTask.self).filter("taskListID = %@", taskList.id))
        
        return items
    }
    var updateTasksAction = TasksService.pullTasksAction
 
    init (taskList: RLMTasksList) {
        self.taskList = taskList
    }
}

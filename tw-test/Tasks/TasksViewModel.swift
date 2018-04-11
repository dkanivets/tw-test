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

protocol TasksViewModelProtocol {
    var taskList: RLMTasksList { get }
    var items: [RLMTask] { get }
    var updateItemsAction: Action<String, [RLMTask], NSError> { get }
}

class TasksViewModel: TasksViewModelProtocol {
    let taskList: RLMTasksList
    var items: [RLMTask] {
        let realm = try! Realm()
        let items = Array(realm.objects(RLMTask.self).filter("taskListID = %@", taskList.id).sorted(by: { $0.id > $1.id }))
        
        return items
    }
    var updateItemsAction = TasksService.pullTasksAction
 
    init (taskList: RLMTasksList) {
        self.taskList = taskList
    }
}

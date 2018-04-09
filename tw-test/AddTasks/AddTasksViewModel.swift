//
//  AddTasksViewModel.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import ReactiveSwift

class AddTasksViewModel: NSObject {
    var items: MutableProperty<[String]> = MutableProperty([])
    var addTasksAction = TasksService.addMulitpleTasksAction
    var taskList: RLMTasksList
    
    init(taskList: RLMTasksList) {
        self.taskList = taskList
        self.items.value = []
    }
}

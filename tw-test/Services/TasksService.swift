//
//  TasksService.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON
import RealmSwift

struct TasksService {
    //Task Lists
    static var pullTaskListsAction: Action<String, [RLMTasksList], NSError> = Action {
        return TasksService.pullTaskLists(projectID: $0)
    }
    
    static func pullTaskLists(projectID: String) -> SignalProducer<[RLMTasksList], NSError> {
        return NetworkService.taskLists(projectID).jsonSignalProducer([:])
            .flatMap(FlattenStrategy.concat, { json -> SignalProducer<[RLMTasksList], NSError> in
                guard let taskLists = json["tasklists"].array,
                    let result = taskLists.failableMap({$0.taskListToStorage()})
                    else {
                        return SignalProducer(error: NSError(domain: "Response can't be parsed", code: 100, userInfo: nil))
                }
                return SignalProducer(value: result)
            })
    }
    
    //Tasks
    static var pullTasksAction: Action<String, [RLMTask], NSError> = Action {
        return TasksService.pullTasks(taskListID: $0)
    }
    
    static func pullTasks(taskListID: String) -> SignalProducer<[RLMTask], NSError> {
        return NetworkService.tasks(taskListID).jsonSignalProducer([:])
            .flatMap(FlattenStrategy.concat, { json -> SignalProducer<[RLMTask], NSError> in
                guard let taskLists = json["todo-items"].array,
                    let result = taskLists.failableMap({$0.taskToStorage()})
                    else {
                        return SignalProducer(error: NSError(domain: "Response can't be parsed", code: 100, userInfo: nil))
                }
                return SignalProducer(value: result)
            })
    }
    
    static var addMulitpleTasksAction: Action<(taskNames: String, taskListID: String, projectID: String), [RLMTask], NSError> = Action {
        return addMultipleTasks(taskNames: $0, taskListID: $1, projectID: $2)
    }
    
    static func addMultipleTasks(taskNames: String, taskListID: String, projectID: String) -> SignalProducer<[RLMTask], NSError> {
        return NetworkService.quickAdd(projectID).jsonSignalProducer(["content" : taskNames as AnyObject, "tasklistId" : taskListID as AnyObject])
            .flatMap(FlattenStrategy.concat, { json -> SignalProducer<[RLMTask], NSError> in
                return TasksService.pullTasks(taskListID: taskListID)
            })
    }
}

private extension JSON {
    func taskListToStorage() -> RLMTasksList? {
        let taskList = RLMTasksList()
        
        guard let id          = self["id"].string,
            let taskListDescr = self["description"].string,
            let name          = self["name"].string,
            let projectId = self["projectId"].string
            else {
                return nil
        }
        
        taskList.id = id
        taskList.tasksListDescr = taskListDescr
        taskList.name = name
        taskList.projectID = projectId
        taskList.write()
        
        return taskList
    }
    
    func taskToStorage() -> RLMTask? {
        let task = RLMTask()
        
        guard let id       = self["id"].int,
            let taskDescr  = self["description"].string,
            let taskListID = self["todo-list-id"].int,
            let name       = self["content"].string else {
                return nil
        }
        
        task.id = "\(id)"
        task.taskDescr = taskDescr
        task.name = name
        task.taskListID = "\(taskListID)"
        task.write()
        
        return task
    }
}

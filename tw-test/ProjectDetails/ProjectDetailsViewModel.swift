//
//  ProjectDetailsViewModel.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 09.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift

protocol ProjectDetailsViewModelProtocol {
    var updateItemsAction: Action<String, [RLMTasksList], NSError> { get }
    var project: RLMProject { get set }
    var items: [RLMTasksList] { get }
}


class ProjectDetailsViewModel: ProjectDetailsViewModelProtocol {
    var project: RLMProject
    var items: [RLMTasksList] {
        let realm = try! Realm()
        let items = Array(realm.objects(RLMTasksList.self).filter("projectID = %@", project.id))
        
        return items
    }
    var updateItemsAction = TasksService.pullTaskListsAction
    
    init (project: RLMProject) {
        self.project = project
    }
}

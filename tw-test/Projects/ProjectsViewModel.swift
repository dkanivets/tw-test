//
//  ProjectsViewModel.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 07.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift

protocol ProjectsViewModelProtocol {
    var updateItemsAction: Action<Void, [RLMProject], NSError> { get }
    var items: [RLMProject] { get }
}

class ProjectsViewModel: ProjectsViewModelProtocol {
    lazy var updateItemsAction = ProjectsService.pullProjectsAction
    var items: [RLMProject] {
        let realm = try! Realm()
        let items = Array(realm.objects(RLMProject.self))
        
        return items
    }
}

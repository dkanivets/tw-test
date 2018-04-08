//
//  ProjectsService.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 08.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON
import Realm

class Project {
    
}

struct ProjectsService {
    
    static var pullProjectsAction: Action<(startFrom: Int, batch: Int), [Project], NSError> = Action {
        return ProjectsService.pull(startFrom: $0, batch: $1)
    }
    
    static func pull(startFrom: Int, batch: Int) -> SignalProducer<[Project], NSError> {
        return NetworkService.projectsList.jsonSignalProducer([:])
            .flatMap(FlattenStrategy.concat, { json -> SignalProducer<[Project], NSError> in
                guard let projects = json["projects"].array,
                    let result = projects.failableMap({$0.projectToStorage()})
                else {
                    return SignalProducer(error: NSError(domain: "Response can't be parsed", code: 100, userInfo: nil))
                }
                return SignalProducer(value: result)
            })
    }
}

private extension JSON {
    func projectToStorage() -> Project {
        return Project()
    }
}

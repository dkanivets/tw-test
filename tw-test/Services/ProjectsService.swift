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
import RealmSwift

struct ProjectsService {
    
    static var pullProjectsAction: Action<Void, [RLMProject], NSError> = Action {
        return ProjectsService.pull()
    }
    
    static func pull() -> SignalProducer<[RLMProject], NSError> {
        return NetworkService.projectsList.jsonSignalProducer([:])
            .flatMap(FlattenStrategy.concat, { json -> SignalProducer<[RLMProject], NSError> in
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
    func projectToStorage() -> RLMProject? {
        let project = RLMProject()
        guard let id = self["id"].string,
            let projectDescr = self["description"].string,
            let status = self["status"].string,
            let defaultPrivacy = self["defaultPrivacy"].string,
            let createdOn = self["created-on"].string,
            let name = self["name"].string,
            let logo = self["logo"].string,
            let endDate = self["endDate"].string,
        let startDate = self["startDate"].string else {
            return nil
        }
        
        project.id = id
        project.projectDescr = projectDescr
        project.status = status
        project.defaultPrivacy = defaultPrivacy
        project.createdOn = createdOn
        project.name = name
        project.logo = logo
        project.endDate = endDate
        project.startDate = startDate
        project.write()
        
        return project
    }
}

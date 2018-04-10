//
//  tw_testTests.swift
//  tw-testTests
//
//  Created by Dmitry Kanivets on 06.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import tw_test

class tw_testTests: XCTestCase {
    
    func testProjectToStorage_shouldMapJSONtoRLMProject() {
        if let path = Bundle.main.path(forResource: "project", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let projectSwiftyJSON = JSON(jsonResult)
                guard let project = projectSwiftyJSON.projectToStorage() else {
                    XCTFail()
                    return
                }
                XCTAssertNotNil(project)
            } catch {
                XCTFail()
            }
        }
    }
    
}

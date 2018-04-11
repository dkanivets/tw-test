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
                let project = projectSwiftyJSON.projectToStorage()
                XCTAssertNotNil(project)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testTaskListToStorage_shouldMapJSONtoRLMTaskList() {
        if let path = Bundle.main.path(forResource: "taskList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let taskListSwiftyJSON = JSON(jsonResult)
                let taskList = taskListSwiftyJSON.taskListToStorage()
                XCTAssertNotNil(taskList)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testTaskToStorage_shouldMapJSONtoRLMTask() {
        if let path = Bundle.main.path(forResource: "task", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let taskSwiftyJSON = JSON(jsonResult)
                let task = taskSwiftyJSON.taskToStorage()
                XCTAssertNotNil(task)
            } catch {
                XCTFail()
            }
        }
    }
}

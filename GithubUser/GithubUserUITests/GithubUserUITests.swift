//
//  GithubUserUITests.swift
//  GithubUserUITests
//
//  Created by mac on 12/12/2567 BE.
//

import XCTest

final class GithubUserUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    @MainActor
    func testUserListAppears() throws {
        let userList = app.tables["UserList"]
        
        XCTAssertTrue(userList.exists, "User list should be visible.")
        
        let firstUserCell = userList.cells.element(boundBy: 0)
        XCTAssertTrue(firstUserCell.exists, "The first user should be visible in the list.")
    }

    @MainActor
    func testErrorMessageDisplayed() throws {
        let errorMessage = app.staticTexts["Error"]
        
        XCTAssertTrue(errorMessage.exists, "Error message should be shown when an error occurs.")
    }

    @MainActor
    func testNavigationToDetailView() throws {
        let userList = app.tables["UserList"]
        
        let firstUserCell = userList.cells.element(boundBy: 0)
        XCTAssertTrue(firstUserCell.exists, "The first user cell should exist.")
        
        firstUserCell.tap()
        
        let userDetailView = app.staticTexts["User Details"]
        XCTAssertTrue(userDetailView.exists, "Should navigate to user detail view.")
    }


    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                 XCUIApplication().launch()
            }
        }
    }
}

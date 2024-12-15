//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by mac on 14/12/2567 BE.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(app.staticTexts["Currency Converter"].exists, "The title should be 'Currency Converter'")
        XCTAssertTrue(app.buttons["Convert"].exists, "The 'Convert' button should be visible")
        XCTAssertTrue(app.textFields["Amount"].exists, "The 'Amount' text field should be visible")
    }

    func testCurrencyConversionSuccess() {
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("100")

        app.buttons["Convert"].tap()

        let resultLabel = app.staticTexts["Converted Amount"]
        XCTAssertTrue(resultLabel.exists, "Result label should contain 'Converted Amount'")

    }

    func testCurrencyConversionFailure() {
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        amountTextField.typeText("-100")

        app.buttons["Convert"].tap()

        let alert = app.alerts["Missing Selection"]
        XCTAssertTrue(alert.exists, "An alert should appear for invalid input")
        XCTAssertTrue(alert.staticTexts["Please enter a valid positive amount."].exists, "The error message should be displayed")
    }
}


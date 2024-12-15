//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by mac on 15/12/2567 BE.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterViewModelTests: XCTestCase {

    var viewModel: CurrencyConverterViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CurrencyConverterViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.selectedFrom, "USD", "Initial 'From' currency should be USD")
        XCTAssertEqual(viewModel.selectedTo, "VND", "Initial 'To' currency should be VND")
        XCTAssertTrue(viewModel.loading, "Initial loading state should be true")
        XCTAssertTrue(viewModel.result.isEmpty, "Initial result should be empty")
    }

    func testFetchCurrenciesSuccess() {
        viewModel.fetchCurrencies()
        
        XCTAssertFalse(viewModel.loading, "Loading should be false after fetching currencies")
        XCTAssertFalse(viewModel.currencies.isEmpty, "Currencies should be fetched and not empty")
    }

    func testConvertCurrencySuccess() {
        viewModel.selectedFrom = "USD"
        viewModel.selectedTo = "EUR"
        viewModel.amount = "100"

        viewModel.convertCurrency()
        
        XCTAssertTrue(viewModel.result.contains("Converted Amount"), "The result should contain 'Converted Amount'")
        XCTAssertFalse(viewModel.converting, "Converting should be false after conversion completes")
    }

    func testConvertCurrencyInvalidAmount() {
        viewModel.amount = "-100"
        viewModel.convertCurrency()

        XCTAssertTrue(viewModel.showAlert, "Alert should be shown for invalid amount")
        XCTAssertEqual(viewModel.alertMessage, "Please enter a valid positive amount.", "The alert message should be for invalid positive amount")
    }
}


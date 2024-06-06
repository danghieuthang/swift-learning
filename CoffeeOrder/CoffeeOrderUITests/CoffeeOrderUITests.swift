//
//  CoffeeOrderUITests.swift
//  CoffeeOrderUITests
//
//  Created by Thắng Đặng on 6/5/24.
//

import XCTest

final class when_app_is_lanched_without_orders: XCTestCase {
    func test_should_make_sure_no_orders_message_is_displayed() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
    }
}

final class when_adding_a_new_coffee_order: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        app.buttons["addNewOrderButton"].tap()

        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]

        nameTextField.tap()
        nameTextField.typeText("Thang")

        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")

        priceTextField.tap()
        priceTextField.typeText("3.0")

        placeOrderButton.tap()
    }

    func test_should_display_coffee_order_in_list_successfull() {
        XCTAssertEqual("Thang", app.staticTexts["orderNameText"].label)
    }

    // call after running each test
    override func tearDown() {
        // clean data in api
    }
}

final class when_deleting_an_order: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        app.buttons["addNewOrderButton"].tap()

        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]

        nameTextField.tap()
        nameTextField.typeText("Thang")

        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")

        priceTextField.tap()
        priceTextField.typeText("3.0")

        placeOrderButton.tap()
    }

    func test_should_delete_order_successfully() {
        let collectionViewQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewQuery.buttons["Delete"].tap()

        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
}

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

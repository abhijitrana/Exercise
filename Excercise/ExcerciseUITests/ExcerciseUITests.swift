//
//  ExcerciseUITests.swift
//  ExcerciseUITests
//
//  Created by Umesh on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import XCTest

class ExcerciseUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
    }

    
    //MARK: - UITest Case For Listing and Details
    func testListWithDetails(){
        
        //Find the list cell element with title
        let titlelabel = app.tables.cells.staticTexts["Beavers"]
        titlelabel.tap()
        XCTAssertTrue(titlelabel.exists)
        
        //Find the detail view element with title
        let detailTitleLabel = app.otherElements.containing(.navigationBar, identifier:"Beavers").children(matching: .other).element.staticTexts["Beavers"]
        detailTitleLabel.tap()
        XCTAssertTrue(detailTitleLabel.exists)
        
        //Find the navigation element with for pop to view
        let navButton = app.navigationBars["Beavers"].buttons["Home"]
        navButton.tap()
        XCTAssertTrue(titlelabel.exists)
    }

}

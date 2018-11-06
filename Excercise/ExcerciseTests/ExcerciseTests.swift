//
//  ExcerciseTests.swift
//  ExcerciseTests
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import XCTest
@testable import Excercise

class ExcerciseTests: XCTestCase {
    
    // MARK: - Inject ViewModel
    let viewModel = ListViewModel(client: APIClient())
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - Unit Test Case For Response Json
    func testGettingJSON() {
        let expect = expectation(description: "Expecting a JSON data not nil")
        
        // View-Model Fetch API Data
        self.viewModel.fetchData()
        
        // View-Model Error Case
        self.viewModel.showError = { error in
            XCTAssertNil(error)
            expect.fulfill()
        }
        
        // View-Model Reload Table view
        self.viewModel.reloadData = { [weak self] in
            guard let strongself = self else {return}
            XCTAssertNotEqual(strongself.viewModel.dataArray.count, 0)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}

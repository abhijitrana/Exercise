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
    }

    override func tearDown() {
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
        
        //Wait for a time interval for getting response from Server
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}

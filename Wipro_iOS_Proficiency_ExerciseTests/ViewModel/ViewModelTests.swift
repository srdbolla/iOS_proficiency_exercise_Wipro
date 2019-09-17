//
//  ViewModelTests.swift
//  Wipro_iOS_Proficiency_ExerciseTests
//
//  Created by Sri Divya Bolla on 17/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import XCTest
@testable import Wipro_iOS_Proficiency_Exercise

class ViewModelTests: XCTestCase {

    let viewModel: ViewModel = ViewModel.shared
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        getJsonAndAssignToRespectiveVariables()
        
    }
    
    func getJsonAndAssignToRespectiveVariables() {
        let expectation = self.expectation(description: "getJsonAndAssignToRespectiveVariables")
        viewModel.callAndAssignDataCompletionBlock { (boolean) in
            XCTAssert(boolean == true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    func testVariablesData() {
        XCTAssert(viewModel.tableViewCellViewModels.count > 0, "viewModel.tableViewCellViewModels count is zero")
        XCTAssertNotNil(viewModel.titleValue.value, "viewModel.titleValue is nil")
        XCTAssertNotNil((viewModel.titleValue.value?.count ?? 0) > 0 , "viewModel.titleValue is empty")
        
        for tableViewCellModel in viewModel.tableViewCellViewModels {
            tableCellViewModelDataTest(tableCellViewModel: tableViewCellModel)
        }
    }
    
    func tableCellViewModelDataTest(tableCellViewModel: TableViewCellViewModel) {
        XCTAssertNotNil(tableCellViewModel.description.value, "description value is nil")
        XCTAssertNotNil(tableCellViewModel.imageURL.value, "imageURL is nil")
        XCTAssertNotNil(tableCellViewModel.rowDetail, "rowDetail is nil")
        XCTAssertNotNil(tableCellViewModel.title.value, "title value is nil")
        XCTAssert((tableCellViewModel.description.value?.count ?? 0) >= 0, "descriptionText is empty")
        XCTAssert((tableCellViewModel.imageURL.value?.count ?? 0) >= 0, "imageURL text is empty")
        XCTAssert((tableCellViewModel.title.value?.count ?? 0) >= 0, "Title text is empty")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

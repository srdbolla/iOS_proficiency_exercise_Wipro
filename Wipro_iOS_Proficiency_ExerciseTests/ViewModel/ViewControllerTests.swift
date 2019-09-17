//
//  ViewControllerTests.swift
//  Wipro_iOS_Proficiency_ExerciseTests
//
//  Created by Sri Divya Bolla on 16/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import XCTest
@testable import Wipro_iOS_Proficiency_Exercise

class ViewControllerTests: XCTestCase {

    var viewController: ViewController?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let navigationController = appDelegate.window?.rootViewController as? UINavigationController,
            let nonNilViewController = navigationController.viewControllers.first as? ViewController {
            viewController = nonNilViewController
        }
        
        self.loadView()
    }
    
    func loadView() {
        _ = viewController?.view
        let expectation = self.expectation(description: "viewController viewDidLoad")
        let delay = DispatchTime.now() + 10.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testSample() {
        XCTAssert(true)
    }
    
    func testVariables() {
        XCTAssertNotNil(viewController?.tableView)
        XCTAssertNotNil(viewController?.refreshControl)
        XCTAssertNotNil(viewController?.viewModel)
    }
    
    func testConfigureNavigationBar() {
        viewController?.configureNavigationBar()
        
        let expectation = self.expectation(description: "viewController configureNavigationBar")
        let delay = DispatchTime.now() + 5.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            XCTAssert((self.viewController?.navigationController?.navigationBar.topItem?.title?.count ?? 0) > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testConfigureTableView() {
        viewController?.configureTableView()
        XCTAssert((viewController?.tableView?.subviews.contains(viewController?.refreshControl ?? UIRefreshControl()) ?? false) == true)
        XCTAssertNotNil(viewController?.tableView?.dataSource)
        XCTAssertNotNil(viewController?.tableView?.delegate)
    }
    
    func testHandleRefresh() {
        viewController?.handleRefresh(refreshControl: viewController?.refreshControl ?? UIRefreshControl())
        
        let expectation = self.expectation(description: "viewController handleRefresh")
        let delay = DispatchTime.now() + 5.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            XCTAssert(self.viewController?.refreshControl.isRefreshing == false)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testAddTableViewConstraints() {
        viewController?.addTableViewConstraints()
        XCTAssert(viewController?.tableView?.translatesAutoresizingMaskIntoConstraints == false)
    }
    
    func testShowErrorAlert() {
        XCTAssertNotNil(viewController?.showErrorAlert(title: "Test title", message: "Test message"))
    }
    
    func testNumberOfSectionsInTableView() {
        XCTAssert(viewController?.tableView?.numberOfSections == 1)
    }
    
    func testNumberOfRowsInSectionOfTableView() {
        if let nonNilTableView = viewController?.tableView {
            for section in 0..<nonNilTableView.numberOfSections {
                XCTAssert(nonNilTableView.numberOfRows(inSection: section) > 0)
            }
        }
    }
    
    func testCellForRowAtIndexPathOfTableView() {
        if let nonNilTableView = viewController?.tableView {
            for section in 0..<nonNilTableView.numberOfSections {
                for row in 0..<nonNilTableView.numberOfRows(inSection: section) {
                    if let tableViewCell = nonNilTableView.cellForRow(at: IndexPath.init(row: row, section: section)) as? TableViewCell {
                        XCTAssertNotNil(tableViewCell.cellImageView)
                        XCTAssertNotNil(tableViewCell.tableViewCellModel)
                        XCTAssertNotNil(tableViewCell.titleLabel)
                        XCTAssert(tableViewCell.titleLabel?.text?.count ?? 0 >= 0)
                        XCTAssertNotNil(tableViewCell.descriptionLabel)
                        XCTAssert(tableViewCell.descriptionLabel?.text?.count ?? 0 >= 0)
                        XCTAssertNotNil(tableViewCell.imageActivityIndicator)
                        XCTAssert(tableViewCell.imageActivityIndicator?.color == UIColor.black)
                    }
                }
            }
        }
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

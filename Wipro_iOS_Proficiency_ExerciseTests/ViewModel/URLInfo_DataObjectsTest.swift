//
//  URLInfo_DataObjectsTest.swift
//  Wipro_iOS_Proficiency_ExerciseTests
//
//  Created by Sri Divya Bolla on 17/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import XCTest
@testable import Wipro_iOS_Proficiency_Exercise

class URLInfo_DataObjectsTest: XCTestCase {

    let urlInfo_DataObject: URLInfo_DataObjects = URLInfo_DataObjects.shared
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetUrlFromURLInfoPlist() {
        XCTAssert(urlInfo_DataObject.getUrlFromURLInfoPlist() == "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", "json url from plist is not matching")
    }
    
    func testGetJSONDataObjectFromUrl() {
        let expectation = self.expectation(description: "testGetJSONDataObjectFromUrl")
        urlInfo_DataObject.getJSONDataObjectFromUrl { (jsonData, error) in
            XCTAssertNotNil(jsonData, "jsonData is nil")
            XCTAssertNil(error, "error is not nil")
            XCTAssertNotNil(jsonData?.title, "jsonData?.title is nil")
            XCTAssertNotNil(jsonData?.rows, "jsonData?.rows is nil")
            XCTAssert((jsonData?.rows.count ?? 0) > 0, "jsonData?.rows doesn't contain data")
            // Commented as few data values are nil from json. If uncommented, the data that contains null will fail.
//            if let jsonDataRows = jsonData?.rows {
//                for row in jsonDataRows {
//                    XCTAssertNotNil(row.description)
//                    XCTAssertNotNil(row.imageHref)
//                    XCTAssertNotNil(row.title)
//                }
//            }
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    func testGetData() {
        if let url: URL = URL.init(string: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg") {
            
            let expectation = self.expectation(description: "testGetData")
            urlInfo_DataObject.getData(from: url) { (data, response, error) in
                XCTAssertNotNil(data, "data is nil")
                XCTAssertNotNil(response, "response is nil")
                XCTAssertNil(error, "error is not nil")
                
                if let nonNilData = data {
                    XCTAssertNotNil(UIImage.init(data: nonNilData), "image doesn't exist with the url")
                }
                expectation.fulfill()
            }
            waitForExpectations(timeout: 30.0, handler: nil)
        }
    }
    
    func testDownloadImage() {
        let imageURLString = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        
        let expectation = self.expectation(description: "testDownloadImage")
        urlInfo_DataObject.downloadImage(from: imageURLString, completion: { (data, error) in
            XCTAssertNotNil(data, "data is nil")
            XCTAssertNil(error, "error is not nil")
            if let nonNilData = data {
                XCTAssertNotNil(UIImage.init(data: nonNilData), "image doesn't exist with the url")
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 30.0, handler: nil)

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

//
//  Model_Objects.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//


import Foundation

/**
 URLInfo confirming to Codable protocol which will be assigned with URL from URLInfo.plist
 */
struct URLInfo: Codable {
    var jsonURL: String
}

/**
 JSONData is created according to the json structure
 */
struct JSONData: Codable {
    var title: String
    var rows: [RowDetails]
}

/**
 RowDetails has been created according to the rows structure in json
 */
struct RowDetails: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}


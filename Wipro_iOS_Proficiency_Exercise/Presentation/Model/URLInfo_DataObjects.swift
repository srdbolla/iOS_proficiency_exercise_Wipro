//
//  URLInfo_DataObjects.swift
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

class URLInfo_DataObjects {
    /**
     Singleton instance
     */
    static let shared = URLInfo_DataObjects()
    
    /**
     Constants
     */
    enum Constants {
        static let urlInfoPlistFileName = "URLInfo"
        static let plistString = "plist"
    }
    
    /**
     initialization method for singleton instance
     */
    private init() {
        
    }
    
    /**
     Method to get the json url from plist
     */
    func getUrlFromURLInfoPlist() -> String {
        if let pathOfUrlInfoFile = Bundle.main.path(forResource: Constants.urlInfoPlistFileName, ofType: Constants.plistString),
            let urlInfoFileData = FileManager.default.contents(atPath: pathOfUrlInfoFile),
            let urlInfo = try? PropertyListDecoder().decode(URLInfo.self, from: urlInfoFileData) {
            return (urlInfo.jsonURL)
        }
        return ""
    }
    
    /**
     To get the data from the url
     */
    func getDataFromUrl() {
        let urlString = getUrlFromURLInfoPlist()
        if urlString != "",
            let url = URL.init(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let jsonData = data,
                    let jsonString = String.init(data: jsonData, encoding: .utf8) {
                    print("jsonString: \(jsonString)")
                }
            }.resume()
        }
    }
}


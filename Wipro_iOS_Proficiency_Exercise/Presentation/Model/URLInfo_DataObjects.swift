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
     Method get json from url and convert the json to JSONObject
     */
    func getJSONDataObjectFromUrl(completionHandler: @escaping (_ jsonDataObject: JSONData?, _ error: Error?) -> Void) {
        let urlString = getUrlFromURLInfoPlist()
        if urlString != "",
            let url = URL.init(string: urlString) {
            getData(from: url) { (data, urlResponse, error) in
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                guard let jsonData = data,
                    let jsonString = String.init(data: jsonData, encoding: .ascii),
                    let encodedDataValue = jsonString.data(using: .utf8),
                    let jsonDataObject = try? JSONDecoder().decode(JSONData.self, from: encodedDataValue) else {
                        completionHandler(nil, error)
                        return
                }
                completionHandler(jsonDataObject, error)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (Data?, Error?)-> Void) {
        if let url = URL.init(string: urlString) {
            URLInfo_DataObjects.shared.getData(from: url) { (data, response, error) in
                completion(data, error)
            }
        } else {
            completion(nil, nil)
        }
    }
    
}


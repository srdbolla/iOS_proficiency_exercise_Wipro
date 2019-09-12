//
//  ViewModel.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

class ViewModel {
    
    public static let shared = ViewModel()
    typealias ProviderCompletionBlock = (JSONData?, Error?) -> Void
    
    var tableViewCellViewModels: [TableViewCellViewModel] = []
    var titleValue: Dynamic<String> = Dynamic("")
    
    private init() {
        
    }
    
    private func callProviderCompletionBlock(callCompletionHandlerValue: @escaping ProviderCompletionBlock) {
        URLInfo_DataObjects.shared.getJSONDataObjectFromUrl(completionHandler: {(jsonDataObject, error) in
            if let error = error {
                callCompletionHandlerValue(nil, error)

            } else {
                guard let jsonDataObject = jsonDataObject else {
                    callCompletionHandlerValue(nil, nil)
                    return
                }
                callCompletionHandlerValue(jsonDataObject, nil)
            }
        })
    }
    
    func callAssignDataCompletionBlock(completionHandler: @escaping (Bool) -> Void) {
        callProviderCompletionBlock { (jsonData, error) in
            if let jsonDataObject = jsonData {
                self.titleValue = Dynamic(jsonDataObject.title)
                for rowDetail in jsonDataObject.rows {
                    let tableViewCellModel: TableViewCellViewModel = TableViewCellViewModel.init(rowDetail: rowDetail)
                    self.tableViewCellViewModels.append(tableViewCellModel)
                }
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

}

//
//  ViewModel.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

/**
 ViewModel for ViewController
 */
class ViewModel {
    
    
    /**
     creating completion block for (JSONData?, Error?) -> Void
    */
    typealias ProviderCompletionBlock = (JSONData?, Error?) -> Void
    
    /**
     tableViewCellViewModels Array to be assigned to each tableViewCell viewModel
    */
    var tableViewCellViewModels: [TableViewCellViewModel] = []
    
    /**
     To dynamically update tableView value for Navigation controller title
    */
    var titleValue: Dynamic<String> = Dynamic("")
    
    
    /**
     Method to return the ProviderCompletionBlock i.e., to fetch json from URL, convert it to JSONData and return the JSONData object
    */
    private func callProviderCompletionBlock(callCompletionHandlerValue: @escaping ProviderCompletionBlock) {
        URLInfo_NetworkCall.shared.getJSONDataObjectFromUrl(completionHandler: {(jsonDataObject, error) in
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
    
    /**
     Method to call callProviderCompletionBlock and assign the data to respective variables
    */
    func callAndAssignDataCompletionBlock(completionHandler: @escaping (Bool) -> Void) {
        callProviderCompletionBlock { [weak self](jsonData, error) in
            if let jsonDataObject = jsonData {
                self?.titleValue.value = jsonDataObject.title
                for rowDetail in jsonDataObject.rows {
                    
                    let tableViewCellModelAlreadyExists = self?.tableViewCellViewModels.contains(where: { (tableViewCellModel) -> Bool in
                        if (tableViewCellModel.title.value == (rowDetail.title ?? "")) && (tableViewCellModel.description.value == (rowDetail.description ?? "")) && (tableViewCellModel.imageURL.value == (rowDetail.imageHref ?? "")) {
                            tableViewCellModel.updateValues(rowDetail: rowDetail)
                            return true
                        }
                        return false
                    })
                    
                    if tableViewCellModelAlreadyExists == false {
                        let tableViewCellModel: TableViewCellViewModel = TableViewCellViewModel.init(rowDetail: rowDetail)
                        self?.tableViewCellViewModels.append(tableViewCellModel)
                    }
                }
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
}

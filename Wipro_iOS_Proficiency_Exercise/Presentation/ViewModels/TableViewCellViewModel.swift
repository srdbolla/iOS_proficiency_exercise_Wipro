//
//  TableViewCellViewModel.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

/**
 ViewModel for TableViewCell
 */
class TableViewCellViewModel {
    
    /**
     Variables
    */
    var imageURL: Dynamic<String> = Dynamic("")
    var title: Dynamic<String> = Dynamic("")
    var description: Dynamic<String> = Dynamic("")
    
    var rowDetail: RowDetails?
    
    /**
     Initializers
    */
    init() {
        self.imageURL = Dynamic("")
        self.title = Dynamic("")
        self.description = Dynamic("")
    }
    
    init(rowDetail: RowDetails) {
        self.rowDetail = rowDetail
        self.imageURL.value = rowDetail.imageHref ?? ""
        self.title.value = rowDetail.title ?? ""
        self.description.value = rowDetail.description ?? ""
    }
    
    /**
     Method to update values
    */
    func updateValues(rowDetail: RowDetails?) {
        self.rowDetail = rowDetail
        self.imageURL.value = rowDetail?.imageHref ?? ""
        self.title.value = rowDetail?.title ?? ""
        self.description.value = rowDetail?.description ?? ""
    }
}

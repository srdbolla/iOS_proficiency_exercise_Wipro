//
//  TableViewCellViewModel.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import Foundation

extension RowDetails: TableViewCellModelDelegate {
    var imageURL: String {
        get {
            return imageHref ?? ""
        }
        set {
            imageHref = newValue
        }
    }
    
    var titleValue: String {
        get {
            return title ?? ""
        }
        set {
            title = newValue
        }
    }
    
    var descriptionValue: String {
        get {
            return description ?? ""
        }
        set {
            description = newValue
        }
    }
}
    
    
protocol TableViewCellModelDelegate {
    var imageURL: String {get set}
    var titleValue: String {get set}
    var descriptionValue: String {get set}
}

class TableViewCellViewModel {
    
    var imageURL: Dynamic<String> = Dynamic("")
    var title: Dynamic<String> = Dynamic("")
    var description: Dynamic<String> = Dynamic("")
    
    init(rowDetail: RowDetails) {
        updateValues(rowDetail: rowDetail)
    }
    
    func updateValues(rowDetail: RowDetails) {
        self.imageURL = Dynamic(rowDetail.imageURL)
        self.title = Dynamic(rowDetail.titleValue)
        self.description = Dynamic(rowDetail.descriptionValue)
    }
}

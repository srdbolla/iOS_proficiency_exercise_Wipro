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
    
    var imageData: Dynamic<Data> = Dynamic(nil)
    var imageDownloaded: Dynamic<Bool> = Dynamic(false)
    var rowDetail: RowDetails?
    
    
    init() {
        self.imageURL = Dynamic("")
        self.title = Dynamic("")
        self.description = Dynamic("")
        self.imageData = Dynamic(nil)
        self.imageDownloaded = Dynamic(false)
    }
    
    init(rowDetail: RowDetails) {
        self.rowDetail = rowDetail
        self.imageURL.value = rowDetail.imageURL
        self.title.value = rowDetail.titleValue
        self.description.value = rowDetail.descriptionValue
        self.imageData.value = nil
        self.imageDownloaded.value = false

    }
    
    func updateValues(rowDetail: RowDetails?) {
        self.rowDetail = rowDetail
        self.imageURL.value = rowDetail?.imageURL
        self.title.value = rowDetail?.titleValue
        self.description.value = rowDetail?.descriptionValue
        
        
        if URLInfo_DataObjects.shared.isRefreshing == true {
            self.imageDownloaded.value = false
        }
    }
}

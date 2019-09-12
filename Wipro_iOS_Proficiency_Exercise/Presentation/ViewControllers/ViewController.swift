//
//  ViewController.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /**
     Constants
     */
    enum Constants {
        static let errorTitle = "There was an error fetching json"
        static let okString = "OK"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAndDisplayData()
    }
    
    /**
     Method to show alert if there is any error while getting the json from the url
    */
    func showErrorAlert() {
        DispatchQueue.main.async {
            let alertController: UIAlertController = UIAlertController.init(title: Constants.errorTitle, message: "", preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction.init(title: Constants.okString, style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /**
     Method to get the data the json data from URL and display in the view controller
     */
    func getAndDisplayData() {
        URLInfo_DataObjects.shared.getJSONDataObjectFromUrl(completionHandler: { [weak self] (jsonDataObject, error) in
            if error != nil {
                self?.showErrorAlert()
            } else {
                guard let jsonDataObject = jsonDataObject else {
                    self?.showErrorAlert()
                    return
                }
                print("jsonDataObject: \(jsonDataObject)")
            }
        })
    }
    
}


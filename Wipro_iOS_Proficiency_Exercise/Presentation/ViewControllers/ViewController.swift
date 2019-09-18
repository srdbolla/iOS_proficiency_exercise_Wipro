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
     Variables
    */
    var tableView: UITableView?
    
    /**
     refresh control variable to handle refresh
    */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    /**
     ViewModel
    */
    var viewModel = ViewModel()
    
    /**
     Constants
     */
    enum Constants {
        static let errorTitle = "There was an error fetching json. Check your network connectivity and  pull down to refresh."
        static let okString = "OK"
        static let tableViewY: CGFloat = 50.0
        static let tableViewX: CGFloat = 0.0
    }
    
    /**
     Existing methods
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
        configureViewModel {_ in }
    }
    
    
    // Custom Methods
    /**
     Method to configure ViewModel-> to load content from jsona nd refresh UI
    */
    func configureViewModel(_ completion: @escaping (Bool) -> Void) {
        viewModel.callAndAssignDataCompletionBlock { [weak self] (boolean) in
            if boolean == true {
                DispatchQueue.main.async {
                    self?.tableView?.reloadData()
                    completion(true)
                }
            } else {
                self?.showErrorAlert(title: Constants.errorTitle, message: "")
                completion(false)
            }
        }
    }
    
    /**
     Method to configure navigationBar title
     */
    func configureNavigationBar() {
        viewModel.titleValue.bind { [weak self] (titleValue) in
            DispatchQueue.main.async {
                self?.navigationController?.navigationBar.topItem?.title = titleValue ?? ""
            }
        }
    }
    
    /**
     Method to configure TableView
    */
    func configureTableView() {
        let tableViewWidth = self.view.frame.size.width
        let viewFrameHeight = self.view.frame.size.height
        let tableViewHeight = viewFrameHeight - Constants.tableViewY
        
        //Initializing tableView
        self.tableView = UITableView.init(frame: CGRect.init(x: Constants.tableViewX, y: Constants.tableViewY, width: tableViewWidth, height: tableViewHeight), style: .plain)
        
        //Confirming to datasource and delegate
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        // Adding tableView to the view if it is not already added
        if let tableViewObject = self.tableView,
            !self.view.subviews.contains(tableViewObject) {
            self.view.addSubview(tableViewObject)
        }
        self.tableView?.reloadData()

        //To dynamically update tableViewCell height based on cell content
        tableView?.estimatedRowHeight = 120.0
        tableView?.rowHeight = UITableView.automaticDimension

        tableView?.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.Constants.identifier)
        
        
        addTableViewConstraints()
        self.tableView?.addSubview(refreshControl)
    }
    
    /**
     Method to handle refresh functionality
    */
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        configureViewModel { _ in
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
        }
    }
    
    /**
     Adding tableView constraints
    */
    func addTableViewConstraints() {
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    /**
     Method to show alert if there is any error while getting the json from the url
    */
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction.init(title: Constants.okString, style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


 // UITableViewDataSource and UITableViewDelegate methods 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.Constants.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        tableViewCell.tableViewCellModel.updateValues(rowDetail: self.viewModel.tableViewCellViewModels[indexPath.row].rowDetail)
        tableViewCell.selectionStyle = .none
        
        return tableViewCell
    }
    
}


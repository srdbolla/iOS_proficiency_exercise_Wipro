//
//  TableViewCell.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import UIKit

/**
 Delegate to update based on TableViewCell values
*/
protocol TableViewCellDelegate {
    /**
     Delegate method to update the image
     */
    func updateCellImageAndReloadAtIndexPath(for tableViewCell: TableViewCell?)
}

class TableViewCell: UITableViewCell {

    /**
     Variables
    */
    var cellImageView: UIImageView?
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var indexPath: IndexPath?
    var delegate: TableViewCellDelegate?
        
    var tableViewCellModel: TableViewCellViewModel = TableViewCellViewModel.init()
    
    
    /**
     Constants
    */
    enum Constants {
        static let multiplerValue: CGFloat = 1.0
        static let constantValue: CGFloat = 0.0
        
        static let edgesAnchorConstantValue: CGFloat = 0.0
        
        static let imageLeadingConstant: CGFloat = 10.0
        static let imageTrailingConstant: CGFloat = -10.0
        
        static let identifier: String = "TableViewCell"
        
        static let noImageName: String = "no_image"
        static let defaultTextValue: String = "Default"
        static let error404ImageName: String = "404_error"
        
    }
    
    /**
     Existing methods
    */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviewsAndConstraints()
        self.initializeAndBindDataToUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView?.image = nil
    }
    
    /// Custom Methods
    /**
        Method to initialize the tableViewCell variable values
     */
    func initializeTableViewCellVariableValues() {
        self.titleLabel?.text = self.tableViewCellModel.title.value
        self.descriptionLabel?.text = self.tableViewCellModel.description.value
        self.cellImageView?.image = nil
    }
    
    /**
     Method to initiazeAndbind the data to UI
    */
    func initializeAndBindDataToUI() {
        initializeTableViewCellVariableValues()
        
        self.tableViewCellModel.title.bind({ [weak self] (titleValue) in
            self?.titleLabel?.text = titleValue
        })
        
        self.tableViewCellModel.description.bind({ [weak self] (descriptionValue) in
            self?.descriptionLabel?.text = descriptionValue
        })
        
        self.tableViewCellModel.imageURL.bind { [weak self] (imageURL) in
            DispatchQueue.main.async {
                if let nonNilIndexPath = self?.indexPath,
                    !ViewController.downloadedImagesDictionary.keys.contains(nonNilIndexPath) {
                    self?.downloadAndDisplayImage(tableViewCellModel: self?.tableViewCellModel)
                }
            }
        }
    }
    
    /**
     Method to download and display the images with activity indicator
    */
    func downloadAndDisplayImage(tableViewCellModel: TableViewCellViewModel?) {
        URLInfo_NetworkCall.shared.downloadImage(from: self.tableViewCellModel.imageURL.value ?? "", completion: { [weak self] (data, error) in
            guard error == nil else {
                self?.stopActivityIndicatorAndAssignImageView(with: nil, self)
                return
            }
            self?.stopActivityIndicatorAndDisplayImages(imageData: data)
        })
    }
    
    
    /**
     Method to stop activity indicator and to display different images based on various errors and data
    */
    func stopActivityIndicatorAndDisplayImages(imageData: Data?) {
        guard let nonNilImageData = imageData else {
            self.stopActivityIndicatorAndAssignImageView(with: nil, self)
            return
        }
        
        guard let imageFromData = UIImage.init(data: nonNilImageData) else {
            self.stopActivityIndicatorAndAssignImageView(with: nil, self)
            return
        }
        
        self.stopActivityIndicatorAndAssignImageView(with: imageFromData, self)
    }
    
    /**
     Method to stop activity indicator and to assign imageView
    */
    func stopActivityIndicatorAndAssignImageView(with image: UIImage?, _ weakSelf: TableViewCell?) {
        DispatchQueue.main.async {
            if let nonNilIndexPath = self.indexPath,
                !ViewController.downloadedImagesDictionary.keys.contains(nonNilIndexPath) {
                ViewController.downloadedImagesDictionary[nonNilIndexPath] = image
            }
            weakSelf?.delegate?.updateCellImageAndReloadAtIndexPath(for: weakSelf)
        }
    }
}

extension TableViewCell {
    
    /**
     Method to configure subviews, and their Constraints
    */
    func configureSubviewsAndConstraints() {
        initializeVariables()
        initializeAutoresizingMaskIntoConstraints()
        addUILabelsAndImageToView()
        configureImageViewConstraints()
        configureTitleLabelConstraints()
        configureDescriptionLabelConstraints()
    }
    
    /**
     Method to initialize variables
    */
    func initializeVariables() {
        self.cellImageView = UIImageView()
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
    }
    
    /**
     Method to add Images and labels to the contentView
    */
    func addUILabelsAndImageToView() {
        if let nonNilCellImageView = cellImageView,
            !self.contentView.contains(nonNilCellImageView) {
            self.contentView.addSubview(nonNilCellImageView)
        }
        if let nonNilTitleLabel = titleLabel,
            !self.contentView.contains(nonNilTitleLabel) {
            titleLabel?.numberOfLines = 0

            self.contentView.addSubview(nonNilTitleLabel)
        }
        if let nonNilDescriptionLabel = descriptionLabel,
            !self.contentView.contains(nonNilDescriptionLabel) {
            descriptionLabel?.numberOfLines = 0
            self.contentView.addSubview(nonNilDescriptionLabel)
        }
    }
    
    /**
     Method to initialize auto resizing mask into constraints
    */
    func initializeAutoresizingMaskIntoConstraints() {
        cellImageView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
//        imageActivityIndicator?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Method to configure imageView constraints
    */
    func configureImageViewConstraints() {
        if let nonNilCellImageView = cellImageView {
            let marginGuide = contentView.layoutMarginsGuide
            
            nonNilCellImageView.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
            nonNilCellImageView.leadingAnchor.constraint(greaterThanOrEqualTo: marginGuide.leadingAnchor, constant: Constants.imageLeadingConstant).isActive = true
            nonNilCellImageView.trailingAnchor.constraint(lessThanOrEqualTo: marginGuide.trailingAnchor, constant: Constants.imageTrailingConstant).isActive = true
            
            nonNilCellImageView.topAnchor.constraint(greaterThanOrEqualTo: marginGuide.topAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            if let nonNilTitleLabel = titleLabel {
                
                nonNilCellImageView.bottomAnchor.constraint(equalTo: nonNilTitleLabel.topAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            }
        }
    }
    
    /**
     Method to configure titlelabel constraints
    */
    func configureTitleLabelConstraints() {
        if let nonNilTitleLabel = titleLabel {
            let marginGuide = contentView.layoutMarginsGuide
            
            nonNilTitleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            nonNilTitleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            
            if let nonNilDescriptionLabel = descriptionLabel {
                nonNilTitleLabel.bottomAnchor.constraint(equalTo: nonNilDescriptionLabel.topAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            }
        }
    }
    
    /**
     Method to configure descriptionLabel constraints
     */
    func configureDescriptionLabelConstraints() {
        if let nonNilDescriptionLabel = self.descriptionLabel {
            let marginGuide = contentView.layoutMarginsGuide
            if let nonNilTitleLabel = self.titleLabel {
                nonNilDescriptionLabel.leadingAnchor.constraint(equalTo: nonNilTitleLabel.leadingAnchor).isActive = true
                nonNilDescriptionLabel.trailingAnchor.constraint(equalTo: nonNilTitleLabel.trailingAnchor).isActive = true                
            }
            
            nonNilDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
        }
    }
}

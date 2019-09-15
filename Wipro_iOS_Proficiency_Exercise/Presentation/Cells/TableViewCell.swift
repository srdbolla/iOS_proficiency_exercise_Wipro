//
//  TableViewCell.swift
//  Wipro_iOS_Proficiency_Exercise
//
//  Created by Sri Divya Bolla on 12/09/19.
//  Copyright © 2019 Sri Divya Bolla. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var cellImageView: UIImageView?
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    
    var imageActivityIndicator: UIActivityIndicatorView?
    
    var tableViewCellModel: TableViewCellViewModel?
    
    /**
     Constants
    */
    enum Constants {
        static let imageViewHeight: CGFloat = 300.0
        static let imageViewWidth: CGFloat = 300.0
        
        static let multiplerValue: CGFloat = 1.0
        static let constantValue: CGFloat = 0.0
        
        static let edgesAnchorConstantValue: CGFloat = 5.0
        
        static let identifier: String = "TableViewCell"
        
        static let noImageName: String = "no_image"
        static let error404ImageName: String = "404_error"
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignValues(tableViewCellModel: TableViewCellViewModel?) {
        self.titleLabel?.text = tableViewCellModel?.title.value
        self.descriptionLabel?.text = tableViewCellModel?.description.value
        downloadAndDisplayImage(tableViewCellModel: tableViewCellModel)
    }
    
    func assignData(tableViewCellModel: TableViewCellViewModel?) {
        assignValues(tableViewCellModel: tableViewCellModel)
        
        tableViewCellModel?.imageURL.bind { (imageURL) in
            self.downloadAndDisplayImage(tableViewCellModel: tableViewCellModel)
        }

        tableViewCellModel?.title.bind({ [weak self] (titleValue) in
            DispatchQueue.main.async {
                self?.titleLabel?.text = titleValue ?? "No title from server"
            }
        })

        tableViewCellModel?.description.bind({ [weak self] (descriptionValue) in
            DispatchQueue.main.async {
                self?.descriptionLabel?.text = descriptionValue ?? "No description from server"
            }
        })
    }
    
    func downloadAndDisplayImage(tableViewCellModel: TableViewCellViewModel?) {
        
        if tableViewCellModel?.imageDownloaded.value == false {
            imageActivityIndicator?.color = UIColor.black
            imageActivityIndicator?.startAnimating()
            imageActivityIndicator?.isHidden = false

            URLInfo_DataObjects.shared.downloadImage(from: tableViewCellModel?.imageURL.value ?? "", completion: { [weak self] (data, error) in
                
                tableViewCellModel?.imageDownloaded.value = true
                tableViewCellModel?.imageData.value = data
                
                guard error == nil else {
                    self?.stopActivityIndicatorAndAssignImageView(with: UIImage.init(named: Constants.error404ImageName), self)
                    return
                }
                
                guard let imageData = data else {
                    self?.stopActivityIndicatorAndAssignImageView(with: UIImage.init(named: Constants.noImageName), self)
                    return
                }
                
                guard let imageFromData = UIImage.init(data: imageData) else {
                    self?.stopActivityIndicatorAndAssignImageView(with: UIImage.init(named: Constants.error404ImageName), self)
                    return
                }
                
                self?.stopActivityIndicatorAndAssignImageView(with: imageFromData, self)
            })
        } else {
            guard let imageData = tableViewCellModel?.imageData.value else {
                self.stopActivityIndicatorAndAssignImageView(with: UIImage.init(named: Constants.noImageName), self)
                return
            }
            
            guard let imageFromData = UIImage.init(data: imageData) else {
                self.stopActivityIndicatorAndAssignImageView(with: UIImage.init(named: Constants.error404ImageName), self)
                return
            }
            
            self.stopActivityIndicatorAndAssignImageView(with: imageFromData, self)

        }
    }
    
    func stopActivityIndicatorAndAssignImageView(with image: UIImage?, _ weakSelf: TableViewCell?) {
        DispatchQueue.main.async {
            weakSelf?.cellImageView?.image = image
            weakSelf?.imageActivityIndicator?.stopAnimating()
            weakSelf?.imageActivityIndicator?.isHidden = true
        }
    }
}

extension TableViewCell {
    func configureSubviewsAndConstraints() {
        initializeVariablesAndAddToView()
        addToView()
        initializeConstraintsForVariables()
        configureImageViewConstraints()
        configureTitleLabelConstraints()
        configureDescriptionLabelConstraints()
        configureImageActivityIndicatorView()
    }
    
    func initializeVariablesAndAddToView() {
        self.cellImageView = UIImageView()
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.imageActivityIndicator = UIActivityIndicatorView.init()
        
        
    }
    
    func addToView() {
        if let nonNilCellImageView = cellImageView,
            !self.contentView.contains(nonNilCellImageView) {
            self.contentView.addSubview(cellImageView ?? nonNilCellImageView)
        }
        if let nonNilTitleLabel = titleLabel,
            !self.contentView.contains(nonNilTitleLabel) {
            self.contentView.addSubview(titleLabel ?? nonNilTitleLabel)
            nonNilTitleLabel.numberOfLines = 0
        }
        if let nonNilDescriptionLabel = descriptionLabel,
            !self.contentView.contains(nonNilDescriptionLabel) {
            self.contentView.addSubview(descriptionLabel ?? nonNilDescriptionLabel)
            nonNilDescriptionLabel.numberOfLines = 0
        }
        if let nonNilImageActivityIndicator = imageActivityIndicator,
            !self.contentView.contains(nonNilImageActivityIndicator) {
            self.contentView.addSubview(imageActivityIndicator ?? nonNilImageActivityIndicator)
        }
    }
    
    func initializeConstraintsForVariables() {
        cellImageView?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        imageActivityIndicator?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureImageViewConstraints() {
        if let nonNilCellImageView = cellImageView {
            let marginGuide = contentView.layoutMarginsGuide
            
            let leadingOrTrailingImageViewConstant: CGFloat = CGFloat((UIScreen.main.bounds.width - (Constants.imageViewWidth))/2)
            
            nonNilCellImageView.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
            
            nonNilCellImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth).isActive = true
            nonNilCellImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight).isActive = true
            nonNilCellImageView.topAnchor.constraint(greaterThanOrEqualTo: marginGuide.topAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            
        }
    }
    
    
    func configureTitleLabelConstraints() {
        if let nonNilTitleLabel = titleLabel {
            let marginGuide = contentView.layoutMarginsGuide
            
            nonNilTitleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            nonNilTitleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            
            if let nonNilCellImageView = cellImageView {
                nonNilTitleLabel.topAnchor.constraint(equalTo: nonNilCellImageView.bottomAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            }
            if let nonNilDescriptionLabel = descriptionLabel {
                nonNilTitleLabel.bottomAnchor.constraint(equalTo: nonNilDescriptionLabel.topAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
            }
            
            let widthConstant = UIScreen.main.bounds.width - ((Constants.edgesAnchorConstantValue*2))
            nonNilTitleLabel.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
    }
    
    func configureDescriptionLabelConstraints() {
        if let nonNilDescriptionLabel = self.descriptionLabel {
            let marginGuide = contentView.layoutMarginsGuide
            if let nonNilTitleLabel = self.titleLabel {
                nonNilDescriptionLabel.leadingAnchor.constraint(equalTo: nonNilTitleLabel.leadingAnchor).isActive = true
                nonNilDescriptionLabel.trailingAnchor.constraint(equalTo: nonNilTitleLabel.trailingAnchor).isActive = true
                nonNilDescriptionLabel.widthAnchor.constraint(equalTo: nonNilTitleLabel.widthAnchor).isActive = true
            }
            
            nonNilDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: Constants.edgesAnchorConstantValue).isActive = true
        }
    }
    
    func configureImageActivityIndicatorView() {
        if let nonImageActivityIndicator = self.imageActivityIndicator,
            let nonNilCellImageView = cellImageView {
            nonImageActivityIndicator.centerXAnchor.constraint(equalTo: nonNilCellImageView.centerXAnchor).isActive = true
            nonImageActivityIndicator.centerYAnchor.constraint(equalTo: nonNilCellImageView.centerYAnchor).isActive = true
        }
    }
    
}

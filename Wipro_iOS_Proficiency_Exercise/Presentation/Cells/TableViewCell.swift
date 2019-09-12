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
    
    
    /**
     Constants
    */
    enum Constants {
        static let imageViewHeight: CGFloat = 40.0
        static let imageViewWidth: CGFloat = 40.0
        
        static let multiplerValue: CGFloat = 1.0
        static let constantValue: CGFloat = 0.0
        
        static let edgesAnchorConstantValue: CGFloat = 20.0
        
        static let identifier: String = "TableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignData(tableViewCellModel: TableViewCellViewModel) {
        tableViewCellModel.imageURL.bind({ [weak self] (imageURL) in
            if let nonNilImageURL = imageURL {
                
            }
        })
        
        tableViewCellModel.title.bind({ [weak self] (titleValue) in
            self?.titleLabel?.text = titleValue ?? ""
        })
        
        tableViewCellModel.description.bind({ [weak self] (descriptionValue) in
            self?.descriptionLabel?.text = descriptionValue ?? ""
        })
    }
}

extension TableViewCell {
    func configureSubviews() {
        configureImageViewAndConstraints()
        configureTitleLabelAndConstraints()
        configureDescriptionLabelAndConstraints()
        configureImageActivityIndicatorView()
    }
    
    func configureImageViewAndConstraints() {
        self.cellImageView = UIImageView()
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.imageActivityIndicator = UIActivityIndicatorView.init()
        
        if let nonNilCellImageView = cellImageView {
            self.contentView.addSubview(nonNilCellImageView)
        }
        if let nonNilTitleLabel = titleLabel {
            self.contentView.addSubview(nonNilTitleLabel)
        }
        if let nonNilDescriptionLabel = descriptionLabel {
            self.contentView.addSubview(nonNilDescriptionLabel)
        }
        if let nonNilImageActivityIndicator = imageActivityIndicator {
            self.contentView.addSubview(nonNilImageActivityIndicator)
        }
        
        if let nonNilCellImageView = cellImageView {
            let cellImageViewConstraints: [NSLayoutConstraint] = [
                nonNilCellImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                nonNilCellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.edgesAnchorConstantValue),
                nonNilCellImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
                nonNilCellImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight)
            ]
            NSLayoutConstraint.deactivate(cellImageViewConstraints)
            NSLayoutConstraint.activate(cellImageViewConstraints)
        }
    }
    
    func configureTitleLabelAndConstraints() {
        if let nonNilTitleLabel = titleLabel {
            var titleLabelLayoutConstraints: [NSLayoutConstraint] = [
                nonNilTitleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: Constants.edgesAnchorConstantValue),
                nonNilTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: Constants.edgesAnchorConstantValue)
            ]
            if let nonNilCellImageView = cellImageView {
                titleLabelLayoutConstraints.append(nonNilTitleLabel.leadingAnchor.constraint(equalTo: nonNilCellImageView.trailingAnchor, constant: Constants.edgesAnchorConstantValue))
            }
            if let nonNilDescriptionLabel = descriptionLabel {
                titleLabelLayoutConstraints.append(nonNilTitleLabel.widthAnchor.constraint(equalTo: nonNilDescriptionLabel.widthAnchor, multiplier: Constants.multiplerValue))
            }
            NSLayoutConstraint.deactivate(titleLabelLayoutConstraints)
            NSLayoutConstraint.activate(titleLabelLayoutConstraints)
        }
    }
    
    func configureDescriptionLabelAndConstraints() {
        if let nonNilDescriptionLabel = self.descriptionLabel {
            var descriptionLabelLayoutConstraints: [NSLayoutConstraint] = [
                nonNilDescriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: Constants.edgesAnchorConstantValue),
                nonNilDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: Constants.edgesAnchorConstantValue)
            ]
            if let nonNilTitleLabel = self.titleLabel {
                descriptionLabelLayoutConstraints.append(nonNilDescriptionLabel.topAnchor.constraint(equalTo: nonNilTitleLabel.bottomAnchor, constant: Constants.edgesAnchorConstantValue))
            }
            if let nonNilCellImageView = cellImageView {
                descriptionLabelLayoutConstraints.append(nonNilDescriptionLabel.leadingAnchor.constraint(equalTo: nonNilCellImageView.trailingAnchor, constant: Constants.edgesAnchorConstantValue))
            }
            NSLayoutConstraint.deactivate(descriptionLabelLayoutConstraints)
            NSLayoutConstraint.activate(descriptionLabelLayoutConstraints)
            
        }
        
    }
    
    func configureImageActivityIndicatorView() {
        if let nonImageActivityIndicator = self.imageActivityIndicator,
            let nonNilCellImageView = cellImageView {
            let activityIndicatorLayoutConstraints: [NSLayoutConstraint] = [
                nonImageActivityIndicator.centerXAnchor.constraint(equalTo: nonNilCellImageView.centerXAnchor),
                nonImageActivityIndicator.centerYAnchor.constraint(equalTo: nonNilCellImageView.centerYAnchor)
            ]
            NSLayoutConstraint.deactivate(activityIndicatorLayoutConstraints)
            NSLayoutConstraint.activate(activityIndicatorLayoutConstraints)
        }
    }
    
}

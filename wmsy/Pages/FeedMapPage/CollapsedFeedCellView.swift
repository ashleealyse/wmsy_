//
//  CollapsedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class CollapsedFeedCellView: UIView {
    
    let profileView = ProfileView()
    
    lazy var userImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.clipsToBounds = true
        return button
    }()
    
    lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var categoryIcon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        setUpImageButton()
        setUpCategoryIcon()
        setUpPostTitleLabel()
    }
    
    private func setUpImageButton() {
        addSubview(userImageButton)
        userImageButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(5)
            make.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(userImageButton.snp.width)
        }
        
    }
    
    private func setUpPostTitleLabel() {
        addSubview(postTitleLabel)
        postTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImageButton.snp.centerY)
            make.leading.equalTo(userImageButton.snp.trailing).offset(5)
            make.trailing.equalTo(categoryIcon.snp.leading).offset(-5)
        }
    }
    
    private func setUpCategoryIcon() {
        addSubview(categoryIcon)
        categoryIcon.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-10)
            make.centerY.equalTo(userImageButton.snp.centerY)
            make.width.equalTo(self.snp.height).multipliedBy(0.3)
            make.height.equalTo(categoryIcon.snp.width)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageButton.layer.cornerRadius = userImageButton.frame.size.height / 2.0
        
    }
    
}

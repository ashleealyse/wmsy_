//
//  MenuProfileView.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuProfileView: UICollectionViewCell {
    
    public var badgeView = UIView()
    public var profileImageView = UIImageView(image: #imageLiteral(resourceName: "wmsyCategoryIcon"))
    public var nameLabel = UILabel()
    public var bioTextView = UITextView()
    public var signOutButton = UIButton()
    public var editBioButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
        placeholderTesting()
    }
    
    private func setupViews() {
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupSignOutButton()
        setupBioTextView()
        setupEditBioButton()
    }
    
    private func setupBadgeView() {
        contentView.addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.6)
            make.top.equalTo(badgeView.snp.bottom).offset(40)
        }
    }
    private func setupNameLabel() {
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(contentView)
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
    }

    private func setupSignOutButton() {
        contentView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(contentView).inset(16)
        }
    }
    private func setupBioTextView() {
        bioTextView.isEditable = false
        contentView.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView).multipliedBy(0.75)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.bottom.equalTo(signOutButton.snp.top).offset(-20)
        }
    }
    private func setupEditBioButton() {
        editBioButton.setTitle("EDIT", for: .normal)
        editBioButton.setTitleColor(.white, for: .normal)
        contentView.addSubview(editBioButton)
        editBioButton.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(bioTextView.layoutMarginsGuide)
        }
    }
    
    private func placeholderTesting() {
        let bgColor = Stylesheet.Colors.WMSYDeepViolet
        let fontColor = Stylesheet.Colors.WMSYPastelBlue
        badgeView.backgroundColor = bgColor
        profileImageView.backgroundColor = bgColor
        nameLabel.backgroundColor = bgColor
        nameLabel.textColor = fontColor
        bioTextView.backgroundColor = bgColor
        bioTextView.textColor = fontColor
        signOutButton.backgroundColor = bgColor
        signOutButton.setTitleColor(fontColor, for: .normal)
        
        nameLabel.text = "HotRod"
        bioTextView.text = "I'm Rod and I like to party."
        signOutButton.setTitle("Signout", for: .normal)
    }
    
}

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
    
    public var badgeView = UIImageView()
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
            make.top.trailing.equalTo(contentView).inset(12)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        badgeView.image = #imageLiteral(resourceName: "badgeIcon")
    }
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.7)
            make.top.equalTo(badgeView.snp.bottom).offset(20)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2.0
        profileImageView.clipsToBounds = true
    }
    private func setupNameLabel() {
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(contentView)
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
        nameLabel.font = UIFont.init(name: "Helvetica", size: 30)
    }

    private func setupSignOutButton() {
        contentView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(contentView).inset(16)
            make.width.equalTo(contentView.snp.width).dividedBy(5 )
        }
        signOutButton.backgroundColor = UIColor.red
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.layer.cornerRadius = 5
        signOutButton.layer.borderWidth = 2.0
        signOutButton.layer.borderColor = UIColor.red.withAlphaComponent(CGFloat(0.5)).cgColor
        
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
        editBioButton.setTitleColor(.black, for: .normal)
        contentView.addSubview(editBioButton)
        editBioButton.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(bioTextView.layoutMarginsGuide)
        }
    }
    
    private func placeholderTesting() {
        let bgColor = UIColor.white
        let fontColor = UIColor.black
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

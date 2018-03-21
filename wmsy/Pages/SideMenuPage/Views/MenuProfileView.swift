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
//    public var header = UIView()
    public var badgeView = UIView()
    public var profileImageView = UIImageView(image: #imageLiteral(resourceName: "wmsyCategoryIcon"))
    public var nameLabel = UILabel()
    public var ageLabel = UILabel()
    public var bioLabel = UILabel()
    public var signOutButton = UIButton()
    
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
        setupAgeLabel()
        setupBioLabel()
        setupSignOutButton()
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
    private func setupAgeLabel() {
        ageLabel.textAlignment = .center
        contentView.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(contentView)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    private func setupBioLabel() {
        contentView.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView).multipliedBy(0.75)
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
        }
    }
    private func setupSignOutButton() {
        contentView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(contentView).inset(16)
        }
    }
    private func placeholderTesting() {
        let bgColor = Stylesheet.Colors.WMSYOuterSpace
        let fontColor = Stylesheet.Colors.WMSYIsabelline
        badgeView.backgroundColor = bgColor
        profileImageView.backgroundColor = bgColor
        ageLabel.backgroundColor = bgColor
        ageLabel.textColor = fontColor
        nameLabel.backgroundColor = bgColor
        nameLabel.textColor = fontColor
        bioLabel.backgroundColor = bgColor
        bioLabel.textColor = fontColor
        signOutButton.backgroundColor = bgColor
        signOutButton.setTitleColor(fontColor, for: .normal)
        
        nameLabel.text = "HotRod"
        ageLabel.text = "4206969 years old"
        bioLabel.text = "I'm Rod and I like to party."
        signOutButton.setTitle("Signout", for: .normal)
    }
}

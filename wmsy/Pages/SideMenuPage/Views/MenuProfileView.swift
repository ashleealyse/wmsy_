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
    
    lazy var badgeView: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "badgeIcon")
        return badge
    }()
    
    lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "artsCategoryIcon")
        img.contentMode = .scaleToFill
        img.layer.borderWidth = 1.0
        img.clipsToBounds = true
        return img
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica", size: 30)
        return lbl
    }()
    
    lazy var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Hey I am t-Swift. I love writing breakup songs"
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var signOutButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Sign Out", for: .normal)
        btn.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupBioTV()
        setUpSignOutButton()
    }
    
    private func setupBadgeView() {
        addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(self.snp.width).multipliedBy(0.5)
            
        }
    }
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupBioTV() {
        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpSignOutButton() {
        addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
}

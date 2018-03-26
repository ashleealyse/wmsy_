//
//  ProfileView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit



class ProfileView: UIView {
    
    //    public var header = UIView()
    public var badgeView = UIView()
    public var profileImageView = UIImageView(image: #imageLiteral(resourceName: "wmsyCategoryIcon"))
    public var nameLabel = UILabel()
    public var ageLabel = UILabel()
    public var bioLabel = UILabel()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancelIcon"), for: .normal)
        return button
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
        placeholderTesting()
    }
    
    private func setupViews() {
        setUpDismissButton()
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupAgeLabel()
        setupBioLabel()
    }
    
    private func setUpDismissButton() {
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
        }
    }
    
    private func setupBadgeView() {
        addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.top.equalTo(badgeView.snp.bottom).offset(40)
        }
    }
    private func setupNameLabel() {
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
        }
    }
    private func setupAgeLabel() {
        ageLabel.textAlignment = .center
       addSubview(ageLabel)
        ageLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    private func setupBioLabel() {
        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
        }
    }

    private func placeholderTesting() {
        let bgColor = Stylesheet.Colors.WMSYDeepViolet
        let fontColor = Stylesheet.Colors.WMSYPastelBlue
        badgeView.backgroundColor = bgColor
        profileImageView.backgroundColor = bgColor
        ageLabel.backgroundColor = bgColor
        ageLabel.textColor = fontColor
        nameLabel.backgroundColor = bgColor
        nameLabel.textColor = fontColor
        bioLabel.backgroundColor = bgColor
        bioLabel.textColor = fontColor
        
        nameLabel.text = "HotRod"
        ageLabel.text = "4206969 years old"
        bioLabel.text = "I'm Rod and I like to party."
    }

}

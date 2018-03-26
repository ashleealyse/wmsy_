//
//  ProfileView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit



class ProfileView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancelIcon"), for: .normal)
        return button
    }()
    
    var badgeView: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "badgeIcon")
        return badge
    }()
    
    var profileImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "artsCategoryIcon")
        img.contentMode = .scaleToFill
        img.layer.borderWidth = 1.0
        img.clipsToBounds = true
        return img
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "T-Swift"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "22"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Hey I am t-Swift. I love writing breakup songs"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.lightText.withAlphaComponent(0.8)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setUpDismissButton()
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupAgeLabel()
        setupBioTV()
    }
    
    private func setUpDismissButton() {
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(70)
            make.leading.equalTo(safeAreaLayoutGuide).offset(30)
            make.width.equalTo(self).multipliedBy(0.05)
            make.height.equalTo(self.snp.width).multipliedBy(0.05)
            
        }
    }
    
    private func setupBadgeView() {
        containerView.addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(70)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-30)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(containerView).offset(100)
            make.width.equalTo(self).multipliedBy(0.3)
            make.height.equalTo(self.snp.width).multipliedBy(0.3)
            
        }
    }
    private func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupAgeLabel() {
        containerView.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupBioTV() {
        containerView.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80).isActive = true
    }
    
    
    
}

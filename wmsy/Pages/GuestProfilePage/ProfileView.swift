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
    
//    var dismissButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "cancelIcon"), for: .normal)
//        return button
//    }()
    
    var badgeView: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "badgeIcon")
        return badge
    }()
    
    var profileImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "artsCategoryIcon")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "T-Swift"
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
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
//        setUpDismissButton()
        setupBadgeView()
        setupProfileImageView()
        setupBioTV()
        setupNameLabel()
    }
    
//    private func setUpDismissButton() {
//        containerView.addSubview(dismissButton)
//        dismissButton.snp.makeConstraints { (make) in
//            make.top.equalTo(containerView).offset(10)
//            make.leading.equalTo(containerView).offset(20)
//            make.width.equalTo(self).multipliedBy(0.05)
//            make.height.equalTo(self.snp.width).multipliedBy(0.05)
//
//        }
//    }
    
    private func setupBadgeView() {
        containerView.addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-12)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(0.5)
            make.leading.equalTo(containerView.snp.leading)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(containerView).offset(-0.5)

            
        }
    }
    private func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(bioLabel.snp.top).offset(10)
            make.leading.equalTo(profileImageView.snp.trailing)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
    
    private func setupBioTV() {
        containerView.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing)
            make.trailing.equalTo(containerView.snp.trailing)
            make.bottom.equalTo(containerView.snp.bottom)
            make.height.equalTo(profileImageView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50).isActive = true
    }
    
    
    
}

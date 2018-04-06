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
    
    var badgeView: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "badgeIcon")
        return badge
    }()
    
    var profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = .purple
        return img
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica", size: 25)
        return lbl
    }()
    
    var bioLabel: UITextView = {
        let lbl = UITextView()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont(name: "Helvetica", size: 18)
        lbl.isEditable = false
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
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupBioTV()
    }
    
    private func setupBadgeView() {
        containerView.addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(8)
            make.trailing.equalTo(containerView).offset(-8)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2.0
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.4)
            make.width.equalTo(profileImageView.snp.height)
        }
    }
    private func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
    
    private func setupBioTV() {
        containerView.addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(containerView.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
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

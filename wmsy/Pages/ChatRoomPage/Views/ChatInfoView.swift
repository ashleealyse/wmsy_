//
//  MemberInfoView.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol ChatInfoViewDelegate: class {
    func inviteOrRemoveUserPressed(sender: UIButton)
    
    
}

class ChatInfoView: UIView {

    lazy var userImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
//        imageView.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        return imageView
    }()
    
    lazy var shortLabel: UILabel = {
       let lb = UILabel()
        lb.backgroundColor = .white
//        lb.backgroundColor = Stylesheet.Colors.WMSYNeonPurple
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lb.text = "Short Label for user name or Whim title"
        return lb
    }()

    lazy var longLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .white
//        lb.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        lb.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lb.numberOfLines = 0
        lb.text = "Long label for user bio or Whim description here with lots of text but only like 100 characters"
        return lb
    }()
    
    lazy var inviteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
                    button.setTitle("Invite", for: .normal)
        button.addTarget(self, action: #selector(inviteUser), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var showMapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        button.setTitle("Map", for: .normal)
        button.addTarget(self, action: #selector(inviteUser), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    weak var delegate: ChatInfoViewDelegate?
    
    @objc func inviteUser() {
        self.delegate?.inviteOrRemoveUserPressed(sender: self.inviteButton)
        print("Invite Button Pressed")
    }
    
    
    // setup custom view
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(userImageView)
        addSubview(shortLabel)
        addSubview(longLabel)
        addSubview(inviteButton)
        addSubview(showMapButton)
        
        
    }
    
    private func setupConstraints() {
        
        userImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
//            make.width.equalTo(self.snp.width).multipliedBy(0.25)
//            make.height.equalTo(userImageView.snp.width)
            make.width.equalTo(userImageView.snp.height)
        }
        
        shortLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
        longLabel.snp.makeConstraints { (make) in
            make.top.equalTo(shortLabel.snp.bottom).offset(5)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }

        inviteButton.snp.makeConstraints { (make) in
            make.top.equalTo(longLabel.snp.bottom).offset(5)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }

        showMapButton.snp.makeConstraints { (make) in
            make.top.equalTo(longLabel.snp.bottom).offset(5)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
//            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.leading.equalTo(longLabel.snp.leading)
        }

        
    }
    
}

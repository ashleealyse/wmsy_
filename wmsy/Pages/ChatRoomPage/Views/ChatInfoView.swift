//
//  MemberInfoView.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ChatInfoView: UIView {

    lazy var shortLabel: UILabel = {
       let lb = UILabel()
        lb.backgroundColor = .orange
        lb.numberOfLines = 0
        lb.text = "Short Label for user name or Whim title"
        return lb
    }()

    lazy var longLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .purple
        lb.numberOfLines = 0
        lb.text = "Long label for user bio or Whim description here with lots of text but only like 100 characters"
        return lb
    }()
    
    lazy var inviteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Invite", for: .normal)
        button.setTitle("Remove", for: .selected)
        return button
    }()
    
    
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
        addSubview(shortLabel)
        addSubview(longLabel)
        addSubview(inviteButton)
        
        
    }
    
    private func setupConstraints() {
        shortLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
        inviteButton.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.width.equalTo(self.snp.width).multipliedBy(0.25)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }

        longLabel.snp.makeConstraints { (make) in
            make.top.equalTo(shortLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(inviteButton.snp.leading).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        
        
    }
    
}

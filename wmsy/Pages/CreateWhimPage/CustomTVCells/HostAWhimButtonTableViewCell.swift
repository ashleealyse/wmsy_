//
//  HostAWhimButtonTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class HostAWhimButtonTableViewCell: UITableViewCell {

    // "Host a Whim" button
    lazy var hostButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        bt.setTitle("Host a Whim", for: .normal)
        return bt
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        setUpConstraints()
    }
    
    func setUpConstraints() {
        contentView.addSubview(hostButton)
        hostButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            let screenHeight = UIScreen.main.bounds.height
            make.height.equalTo(screenHeight * 0.1)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            
        }
    }
}

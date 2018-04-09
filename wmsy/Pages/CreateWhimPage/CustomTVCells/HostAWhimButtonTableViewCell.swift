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
        bt.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.7)
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
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            let screenHeight = UIScreen.main.bounds.height
            make.height.equalTo(81)
            make.bottom.equalTo(contentView.snp.bottom)
            
        }
    }
}

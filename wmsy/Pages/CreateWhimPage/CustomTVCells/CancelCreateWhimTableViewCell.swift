//
//  CancelCreateWhimTableViewCell.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CancelCreateWhimTableViewCell: UITableViewCell {

    // "Host a Whim" button
    lazy var cancelButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.9)
        bt.setTitle("Cancel", for: .normal)
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
        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            let screenHeight = UIScreen.main.bounds.height
            make.height.equalTo(screenHeight * 0.04)
            make.bottom.equalTo(contentView.snp.bottom)
            
        }
    }

}

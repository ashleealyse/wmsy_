//
//  MenuWhimsHeader.swift
//  wmsy
//
//  Created by C4Q on 3/17/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuWhimsHeader: UITableViewHeaderFooterView {
    public let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = Stylesheet.Colors.WMSYOuterSpace
        setupViews()
        placeholderTesting()
    }
    
    private func setupViews() {
        setupTitleLabel()
    }
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func placeholderTesting() {
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        titleLabel.textColor = Stylesheet.Colors.WMSYSeaFoamGreen
        titleLabel.text = "Host Chats"
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

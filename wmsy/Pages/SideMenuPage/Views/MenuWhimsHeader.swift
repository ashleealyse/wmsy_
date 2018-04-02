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
    
    static let reuseIdentifier = "MenuWhimsHeader"
    
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
        contentView.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.1)
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
        titleLabel.font = UIFont(name: "Helvetica-Light", size: 30)
        titleLabel.textColor = Stylesheet.Colors.WMSYDeepViolet
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

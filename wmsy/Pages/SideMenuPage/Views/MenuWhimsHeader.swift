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
        backgroundColor = .clear
        contentView.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.2)
        setupViews()
        placeholderTesting()
        contentView.addBorders(edges: .bottom, color: Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.1), thickness: 0.5)
    }
    
    private func setupViews() {
        setupTitleLabel()
    }
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func placeholderTesting() {
        titleLabel.font = UIFont(name: "Helvetica", size: 25)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = Stylesheet.Colors.WMSYDeepViolet
    }

}

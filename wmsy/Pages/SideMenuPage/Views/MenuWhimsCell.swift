//
//  MenuWhimsCell.swift
//  wmsy
//
//  Created by C4Q on 3/18/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuWhimsCell: UITableViewCell {
    
    static let reuseIdentifier = "MenuWhimsCell"
    public var whimTitle = UILabel()
    public var notificationBadge = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        setupViews()
        contentView.addBorders(edges: .bottom, color: Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.3), thickness: 0.5)
    }
    private func setupViews() {
        setupWhimTitle()
        setupNotificationBadge()
    }
    
    private func setupWhimTitle() {
        whimTitle.textColor = Stylesheet.Colors.WMSYKSUPurple
        contentView.addSubview(whimTitle)
        whimTitle.numberOfLines = 2
        whimTitle.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func setupNotificationBadge() {
        contentView.addSubview(notificationBadge)
        notificationBadge.snp.makeConstraints { (make) in
            make.height.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.centerY.equalTo(contentView)
            make.width.equalTo(5)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.5)
            whimTitle.textColor = .white
        } else {
            contentView.backgroundColor = .clear
            whimTitle.textColor = Stylesheet.Colors.WMSYKSUPurple
        }
    }
}

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
    private var notificationBadge = UIView()
    
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
    }
    private func setupViews() {
        setupWhimTitle()
        setupNotificationBadge()
    }
    
    private func setupWhimTitle() {
        whimTitle.textColor = .white
        contentView.addSubview(whimTitle)
        whimTitle.numberOfLines = 2
        whimTitle.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func setupNotificationBadge() {
        contentView.addSubview(notificationBadge)
        notificationBadge.layer.cornerRadius = 15 / 2
        notificationBadge.clipsToBounds = true
        notificationBadge.snp.makeConstraints { (make) in
            make.height.width.equalTo(15)
            make.centerX.equalTo(whimTitle.snp.trailing)
            make.centerY.equalTo(whimTitle.snp.top)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
            whimTitle.textColor = Stylesheet.Colors.WMSYKSUPurple
        } else {
            contentView.backgroundColor = .clear
            whimTitle.textColor = .white
        }
    }
}

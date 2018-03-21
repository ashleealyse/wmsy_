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
    
    private var whimTitle = UILabel()
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
//        backgroundColor = Stylesheet.Colors.WMSYIsabelline
        backgroundColor = .clear
        setupViews()
        placeholderTesting()
    }
    private func setupViews() {
        setupWhimTitle()
        setupNotificationBadge()
    }
    
    private func setupWhimTitle() {
        whimTitle.textColor = Stylesheet.Colors.WMSYMummysTomb
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
    private func placeholderTesting() {
        whimTitle.text = "Testing putting some very long message in a chat title when looking at it through a menu. This text is set in MenuWhimsCell.swift"
        notificationBadge.backgroundColor = .red
        selectionStyle = .none
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        UIView.animate(withDuration: 0.4, animations: {
            if selected {
                self.backgroundColor = Stylesheet.Colors.WMSYMummysTomb
            } else {
                self.backgroundColor = .clear
            }
        })
    }
}

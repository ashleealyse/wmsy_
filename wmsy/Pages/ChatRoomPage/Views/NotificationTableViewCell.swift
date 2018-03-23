//
//  NotificationTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}

class NotificationTableViewCell: UITableViewCell {
    
    public var notificationLabel = UnderlinedLabel()
    
    
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
        // Initialization code
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        placeholderTesting()
    }
    private func setupViews() {
        setupNotificationLabel()
    }
    private func setupNotificationLabel() {
        notificationLabel.textAlignment = .center
        notificationLabel.textColor = Stylesheet.Colors.WMSYPastelBlue
        contentView.addSubview(notificationLabel)
        notificationLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView).inset(100)
            make.top.bottom.equalTo(contentView).inset(15)
        }
    }
    private func placeholderTesting() {
        selectionStyle = .none
        notificationLabel.text = "here is a simple notification"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

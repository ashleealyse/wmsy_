//
//  GuestMessageTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class OtherUserMessageCell: UITableViewCell {
    
    static let reuseIdentifier = "GuestMessageTableViewCell"
    public var profileImageView = UIImageView()
    private var textContainer = UIView()
    public var messageText = UILabel()
    
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
        self.backgroundColor = .clear
        setupViews()
        placeholderTesting()
    }
    private func setupViews() {
        setupProfileImageView()
        setupTextContainer()
        setupMessageText()
    }
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2.0
        profileImageView.layer.masksToBounds = true
        profileImageView.snp.makeConstraints { (make) in
            make.bottom.leading.equalTo(contentView.layoutMarginsGuide)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupTextContainer() {
        contentView.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
//            make.trailing.equalTo(contentView).offset(-50)
            make.trailing.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func setupMessageText() {
        messageText.numberOfLines = 0
        messageText.setContentHuggingPriority(.required, for: .vertical)
        messageText.setContentCompressionResistancePriority(.required, for: .vertical)
        messageText.preferredMaxLayoutWidth = self.bounds.width - 10
        textContainer.addSubview(messageText)
        messageText.snp.makeConstraints { (make) in
            make.edges.equalTo(textContainer).inset(5)
        }
    }
    private func placeholderTesting() {
        selectionStyle = .none
        textContainer.backgroundColor = .white
        textContainer.layer.borderWidth = 1.0
        textContainer.layer.borderColor = Stylesheet.Colors.WMSYKSUPurple.cgColor
        textContainer.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

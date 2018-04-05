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
//        placeholderTesting()
    }
    private func setupViews() {
        setupProfileImageView()
        setupTextContainer()
        setupMessageText()
    }
    private func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2.0
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).inset(5)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.1)
            make.bottom.lessThanOrEqualTo(contentView).inset(5)
        }
    }
    private func setupTextContainer() {
        textContainer.backgroundColor = Stylesheet.Colors.WMSYDeepViolet.withAlphaComponent(0.075)
        textContainer.layer.cornerRadius = 10
        contentView.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(contentView).inset(5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualTo(contentView).inset(70)
        }
    }
    private func setupMessageText() {
        messageText.numberOfLines = 0
//        messageText.setContentHuggingPriority(.required, for: .vertical)
//        messageText.setContentCompressionResistancePriority(.required, for: .vertical)
//        messageText.preferredMaxLayoutWidth = self.bounds.width - 10
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

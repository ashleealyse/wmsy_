//
//  HostMessageTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CurrentUserMessageCell: UITableViewCell {
    
    static let reuseIdentifier = "HostMessageTableViewCell"
    
    private var profileImageView = UIImageView()
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
        contentView.layoutMarginsGuide.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(profileImageView)
        }
    }
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(contentView.layoutMarginsGuide)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupTextContainer() {
        contentView.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            make.trailing.equalTo(profileImageView.snp.leading).offset(-16)
//            make.leading.equalTo(contentView).offset(50)
            make.leading.equalTo(contentView).offset(70)
            make.top.equalTo(profileImageView)
            make.bottom.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func setupMessageText() {
        messageText.numberOfLines = 0
        textContainer.addSubview(messageText)
        messageText.snp.makeConstraints { (make) in
            make.edges.equalTo(textContainer.layoutMarginsGuide)
        }
    }
    private func placeholderTesting() {
        selectionStyle = .none
        messageText.text = "oqiudfboasiudfboaiuefoqwieufoaisdufoiasdhfoiasudhfoaisduhfoiasufhoaidufhoaisdufhoaisdufhoaisdufhpqiwuyefhldjkahsguoyiryqwoj;eklafdnshore;ifdhbaiosldfhubauie8o;fuijblajsdkufhSLkdhj"
        profileImageView.backgroundColor = .red
        textContainer.backgroundColor = .blue
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

//
//  HostMessageTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


class MyCell: UITableViewCell {
    lazy var dummyImage: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        v.layer.cornerRadius = 25
        return v
    }()
    
    lazy var messageBackground: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        v.layer.cornerRadius = 5
        return v
    }()
    
    lazy var someLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.backgroundColor = .red
        l.textColor = .white
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }
    
    func layoutViews() {
        contentView.addSubview(dummyImage)
        contentView.addSubview(messageBackground)
        messageBackground.addSubview(someLabel)
        
        NSLayoutConstraint.activate([
            dummyImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dummyImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dummyImage.widthAnchor.constraint(equalToConstant: 50),
            dummyImage.heightAnchor.constraint(equalTo: dummyImage.widthAnchor),
            dummyImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            
            messageBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), //change this to lessThanOrEqualTo if you want the message to be as minimal as possible (see the case where there's one line of text)
            messageBackground.leadingAnchor.constraint(equalTo: dummyImage.trailingAnchor, constant: 12),
            messageBackground.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            someLabel.trailingAnchor.constraint(lessThanOrEqualTo: messageBackground.trailingAnchor, constant: -5),
            someLabel.topAnchor.constraint(equalTo: messageBackground.topAnchor, constant: 5),
            someLabel.bottomAnchor.constraint(equalTo: messageBackground.bottomAnchor, constant: -5),
            someLabel.leadingAnchor.constraint(equalTo: messageBackground.leadingAnchor, constant: 5)
            ])
    }
}

class CurrentUserMessageCell: UITableViewCell {
    
    static let reuseIdentifier = "HostMessageTableViewCell"
    
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
            make.top.trailing.equalTo(contentView).inset(5)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.1)
            make.bottom.lessThanOrEqualTo(contentView).inset(5)
        }
    }
    private func setupTextContainer() {
        textContainer.backgroundColor = Stylesheet.Colors.WMSYDeepViolet.withAlphaComponent(0.03)
        textContainer.layer.cornerRadius = 10
        contentView.addSubview(textContainer)
        textContainer.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).inset(5)
            make.bottom.equalTo(contentView).inset(5)
            make.trailing.equalTo(profileImageView.snp.leading).offset(-16)
            make.leading.greaterThanOrEqualTo(contentView).offset(70)
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
//            make.width.equalTo(textContainer).inset(10)
//            make.centerX.equalTo(textContainer)
//            make.top.bottom.equalTo(textContainer)
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

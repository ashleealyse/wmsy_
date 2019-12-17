//
//  CardCell.swift
//  wmsy_
//
//  Created by Lynk on 12/8/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


protocol CardCellDelegate: AnyObject {
    func profilePressed()
}



class CardCell: UITableViewCell {
    lazy var card: UIView = {
        let v = UIView()
        v.layer.shadowColor = UIColor.gray.cgColor
        v.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        v.layer.shadowRadius = 3.0
        v.layer.shadowOpacity = 1
        v.backgroundColor = .clear
        self.backgroundImage.layer.shadowPath = UIBezierPath(roundedRect: v.bounds, cornerRadius: 10).cgPath
        v.layer.masksToBounds = false
        v.clipsToBounds = false
        return v
    }()
    
    weak var delegate: CardCellDelegate?
    
    
    lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20.0
        return iv
    }()
    
    
    lazy var profilePicture: UIButton = {
        let iv = UIButton()
        iv.tintColor = .white
        iv.setBackgroundImage(UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        iv.addTarget(self, action: #selector(profilePressed), for: .touchUpInside)
        return iv
    }()
    
    lazy var profileName: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    lazy var timeLeft: UILabel = {
        let label = UILabel()
        label.text = "2 hrs left"
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        label.textColor = .lightText
        label.textAlignment = .right
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Event!!!"
        label.textColor = .white
        let font = UIFont.systemFont(ofSize: 25)
        let fontMetrics = UIFontMetrics(forTextStyle: .headline)
        label.font = fontMetrics.scaledFont(for: font)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.text = " sadfa sdhfh ads ihj ufasui fiuas hd iud fa udhas jui kdhi aus hdui as hdi uashsd iuahsu idhi a uh dh siua sh diuh"
        tv.textColor = .white
        tv.backgroundColor = .clear
        return tv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
        
    }
    
   
    
    func commonInit() {
        backgroundImage.isUserInteractionEnabled = true
        descriptionTextView.isUserInteractionEnabled = false
        addSubviews(subviews: [card])
        card.addSubviews(subviews: [backgroundImage])
        backgroundImage.addSubviews(subviews: [titleLabel, profilePicture, descriptionTextView])
        backgroundColor = .clear
        isOpaque = false
        selectionStyle = .none
        constrainCard()
        card.constrainToAllSides(item: backgroundImage, sides: ([.top,.left,.right,.bottom],[]))
        constrainTitleLabel()
        constrainProfilePicture()
        constrainUserInfoStack()
        constrainDescription()
        bringSubviewToFront(card)
    }
    
    
    @objc func profilePressed() {
        delegate?.profilePressed()
    }
    
    
    
    func constrainCard () {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            card.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            card.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 11),
            card.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -11)
        ])
    }
    
    func constrainTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 11),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 11),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func constrainProfilePicture() {
        NSLayoutConstraint.activate([
            profilePicture.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -11),
            profilePicture.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -11),
            profilePicture.heightAnchor.constraint(equalToConstant: 35),
            profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor)
        ])
    }
    
    func constrainUserInfoStack () {
        let stack = UIStackView(arrangedSubviews: [profileName,timeLeft])
        stack.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.addSubview(stack)
        stack.axis = .vertical
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: profilePicture.leadingAnchor, constant: -5),
            stack.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor)
        
        ])
    }
    
    
    func constrainDescription() {
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionTextView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 11),
            descriptionTextView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -11),
            descriptionTextView.bottomAnchor.constraint(equalTo: profilePicture.topAnchor, constant: -5)
        
        ])
    }
    
    
}

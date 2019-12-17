//
//  ProfileHeader.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit



class ProfileHeader: UICollectionReusableView {
    lazy var colorView: UIView = {
        let v = UIView()
        v.backgroundColor = WmsyColors.headerPurple
        return v
    }()
    
    lazy var profilePicture: UIImageView = {
      let iv = UIImageView()
        let image = UIImage(named: "spike")
        iv.image = image
        iv.layer.borderColor = UIColor.systemGray6.cgColor
        iv.layer.borderWidth = 7
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Spike Spiegel, 27"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
     
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Whatever happens, happens"
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
        backgroundColor = .systemGray6
    }
    
    func commonInit() {
        addSubviews(subviews: [colorView, profilePicture, nameLabel, descriptionLabel])
        constrainColorView()
        constrainProfileImage()
        constrainNameLabel()
        constrainDescriptionLabel()
        super.layoutIfNeeded()
        profilePicture.layer.cornerRadius = profilePicture.frame.width/2.0

    }
    
    
    func constrainNameLabel() {
        constrainToAllSides(item: nameLabel, sides: ([.left,.right],[nameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 11)]))
    }
    
    func constrainDescriptionLabel() {
        constrainToAllSides(item: descriptionLabel, sides: ([.left,.right],[descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)]))
       

    }
    
    func constrainProfileImage() {
        NSLayoutConstraint.activate([
            profilePicture.centerYAnchor.constraint(equalTo: colorView.bottomAnchor),
            profilePicture.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 200),
            profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor)
        ])
    }
    
    
    func constrainColorView() {
        constrainToAllSides(item: colorView, sides: ([.left,.right,.top],[colorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)]))
       
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
                profilePicture.layer.borderColor = UIColor.systemGray6.cgColor
    }
}

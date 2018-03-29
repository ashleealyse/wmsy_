//
//  MenuProfileView.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuProfileView: UICollectionViewCell {
    
    lazy var badgeView: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "badgeIcon")
        return badge
    }()
    
    lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "artsCategoryIcon")
        img.contentMode = .scaleToFill
        img.layer.borderWidth = 1.0
        img.clipsToBounds = true
        return img
    }()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica", size: 30)
        return lbl
    }()
    
    /*
lazy var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Hey I am t-Swift. I love writing breakup songs"
        lbl.textColor = .black
        return lbl
    }()
*/
    
    lazy var signOutButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Sign Out", for: .normal)
        btn.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        return btn
    }()

    public var bioTextView = UITextView()
    public var editBioButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupBadgeView()
        setupProfileImageView()
        setupNameLabel()
        setupSignOutButton()
        setupBioTextView()
        setupEditBioButton()
    }
    
    private func setupBadgeView() {
        addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(self).multipliedBy(0.1)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
        }
    }
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(self.snp.width).multipliedBy(0.5)
            
        }
    }
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }

    /*
    private func setupBioTV() {
        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
            make.centerX.equalTo(self)
        }
    }
    */


    private func setupSignOutButton() {
        contentView.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (make) in
            make.leading.bottom.equalTo(contentView).inset(16)
        }
    }
    private func setupBioTextView() {
        bioTextView.isEditable = false
        contentView.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView).multipliedBy(0.75)
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
            make.bottom.equalTo(signOutButton.snp.top).offset(-20)
        }
    }
    private func setupEditBioButton() {
        editBioButton.setTitle("EDIT", for: .normal)
        editBioButton.setTitleColor(.white, for: .normal)
        contentView.addSubview(editBioButton)
        editBioButton.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(bioTextView.layoutMarginsGuide)
        }
    }
    
    private func placeholderTesting() {
        let bgColor = Stylesheet.Colors.WMSYDeepViolet
        let fontColor = Stylesheet.Colors.WMSYPastelBlue
        badgeView.backgroundColor = bgColor
        profileImageView.backgroundColor = bgColor
        ageLabel.backgroundColor = bgColor
        ageLabel.textColor = fontColor
        nameLabel.backgroundColor = bgColor
        nameLabel.textColor = fontColor
        bioTextView.backgroundColor = bgColor
        bioTextView.textColor = fontColor
        signOutButton.backgroundColor = bgColor
        signOutButton.setTitleColor(fontColor, for: .normal)

        nameLabel.text = "HotRod"
        ageLabel.text = "4206969 years old"
        bioTextView.text = "I'm Rod and I like to party."
        signOutButton.setTitle("Signout", for: .normal)
    }
    
 
    
//
//    var badgeView: UIImageView = {
//        let badge = UIImageView()
//        badge.image = #imageLiteral(resourceName: "badgeIcon")
//        return badge
//    }()
//
//    var profileImageView: UIImageView = {
//        let img = UIImageView()
//        img.image = #imageLiteral(resourceName: "artsCategoryIcon")
//        img.contentMode = .scaleToFill
//        img.layer.borderWidth = 1.0
//        img.clipsToBounds = true
//        return img
//    }()
//
//    var nameLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "T-Swift"
//        lbl.textAlignment = .center
//        return lbl
//    }()
//
//    var ageLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "22"
//        lbl.textAlignment = .center
//        return lbl
//    }()
//
//    var bioLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.numberOfLines = 0
//        lbl.textAlignment = .center
//        lbl.text = "Hey I am t-Swift. I love writing breakup songs"
//        return lbl
//    }()
//
//
//    var signOutButton: UIButton = {
//       let button = UIButton()
//        button.setTitle("Sign Out", for: .normal)
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    convenience init() {
//        self.init(frame: UIScreen.main.bounds)
//        backgroundColor = UIColor.black.withAlphaComponent(0.5)
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    private func commonInit() {
//        setupViews()
//    }
//
//    private func setupViews() {
//        setupBadgeView()
//        setupProfileImageView()
//        setupNameLabel()
//        setupAgeLabel()
//        setupBioTV()
//        setUpSignOutButton()
//    }
//
//
//
//    private func setupBadgeView() {
//        addSubview(badgeView)
//        badgeView.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide).offset(70)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-30)
//            make.width.equalTo(self).multipliedBy(0.1)
//            make.height.equalTo(self.snp.width).multipliedBy(0.1)
//        }
//    }
//    private func setupProfileImageView() {
//        addSubview(profileImageView)
//        profileImageView.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self)
//            make.top.equalTo(safeAreaLayoutGuide).offset(100)
//            make.width.equalTo(self).multipliedBy(0.3)
//            make.height.equalTo(self.snp.width).multipliedBy(0.3)
//
//        }
//    }
//    private func setupNameLabel() {
//       addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(profileImageView.snp.bottom).offset(10)
//            make.centerX.equalTo(self)
//        }
//    }
//
//    private func setupAgeLabel() {
//        addSubview(ageLabel)
//        ageLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self)
//        }
//    }
//
//    private func setupBioTV() {
//       addSubview(bioLabel)
//        bioLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(ageLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self)
//        }
//    }
//
//    func setUpSignOutButton() {
//        addSubview(signOutButton)
//        signOutButton.snp.makeConstraints { (make) in
//            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
//            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
//        }
//    }
    


    
}

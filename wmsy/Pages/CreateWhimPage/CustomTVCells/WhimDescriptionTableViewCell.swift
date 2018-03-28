//
//  DescriptionTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimDescriptionTableViewCell: UITableViewCell {

    
    // Description TextField with Max 200 Characters
//    lazy var descriptionTextfield: UITextField = {
//        let tf = UITextField()
//        tf.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
//        tf.borderStyle = .roundedRect
//        tf.placeholder = "Describe your Whim"
//        return tf
//    }()
    
    lazy var descriptionTextView: UITextView = {
       let tv = UITextView()
        tv.isEditable = true
        tv.backgroundColor = .white
//        tv.layer.borderWidth = 0.5
//        tv.layer.borderColor = Stylesheet.Colors.WMSYKSUPurple.cgColor
        tv.font = UIFont.boldSystemFont(ofSize: 20)
        tv.text = "Description"
        tv.textColor = .gray
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 5.0
        return tv
    }()
    
    // Dynamic label with remaining characters out of 200
    lazy var charactersRemainingLabel: UILabel = {
        let lb = UILabel()
//        lb.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.text = "0/100"
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        setUpConstraints()
    }
    
    func setUpConstraints() {
//        contentView.addSubview(descriptionTextfield)
//        descriptionTextfield.snp.makeConstraints { (make) in
//            make.top.equalTo(contentView.snp.top).offset(5)
//            make.leading.equalTo(contentView.snp.leading).offset(5)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
////            make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
//        }
//
//        contentView.addSubview(charactersRemainingLabel)
//        charactersRemainingLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(descriptionTextfield.snp.bottom).offset(5)
//            make.leading.equalTo(contentView.snp.leading).offset(5)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
//            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
//        }
        
        
        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            let screenHeight: CGFloat = UIScreen.main.bounds.height
            make.height.equalTo(screenHeight / 10)
        }
        
        contentView.addSubview(charactersRemainingLabel)
        charactersRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        
    }
    


}

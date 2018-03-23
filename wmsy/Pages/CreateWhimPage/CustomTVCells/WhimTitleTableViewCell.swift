//
//  TitleTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimTitleTableViewCell: UITableViewCell {

    // Title Textfield with max 100 characters
    lazy var titleTextfield: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter a title for your Whim"
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.clearButtonMode = .always
        return tf
    }()
    
    // Dynamic label with remaining characters out of 100
    lazy var charactersRemainingLabel: UILabel = {
        let lb = UILabel()
//        lb.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        lb.textAlignment = .right
        lb.text = "0/50"
        lb.font = UIFont.systemFont(ofSize: 15)
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
        contentView.addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            let screenHeight: CGFloat = UIScreen.main.bounds.height
            make.height.equalTo(screenHeight / 15)
//            make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        contentView.addSubview(charactersRemainingLabel)
        charactersRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextfield.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    


}

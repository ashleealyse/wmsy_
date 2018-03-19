//
//  WhimExpirationTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimExpirationTableViewCell: UITableViewCell {

    // Label instructions for Pickerview: "Whim will expire in __ hours"
    lazy var expirationLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = Stylesheet.Colors.WMSYAshGrey
        lb.text = "hours until Whim expires"
        return lb
    }()
    
    // Pickerview with 1 - 24 hours
    lazy var hourPickerView: UIPickerView = {
       let pv = UIPickerView()
        pv.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        pv.clipsToBounds = true
        return pv
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
        
        contentView.addSubview(hourPickerView)
        hourPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.3)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
//            let screenHeight = UIScreen.main.bounds.height
//            make.height.equalTo(screenHeight).multipliedBy(0.1)
        }
        
        
        contentView.addSubview(expirationLabel)
        expirationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
//            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.leading.equalTo(hourPickerView.snp.trailing).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
       
    }
    
    


}

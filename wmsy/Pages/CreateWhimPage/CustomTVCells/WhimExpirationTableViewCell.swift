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
        lb.text = "Whim will expire in _ hours"
        return lb
    }()
    
    // Pickerview with 1 - 24 hours
    lazy var hourPickerView: UIPickerView = {
       let pv = UIPickerView()
        
        
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
        contentView.addSubview(expirationLabel)
        expirationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
        }
        
        contentView.addSubview(hourPickerView)
        hourPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(expirationLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  WhimLocationTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimLocationTableViewCell: UITableViewCell {

    // Address Label
    lazy var addressLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Drop Pin"
        lb.textColor = Stylesheet.Colors.WMSYKSUPurple
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.numberOfLines = 0
        return lb
    }()
    
    // Button to select address: "Open Map to Select Meeting Location"
    lazy var selectLocationButton: UIButton = {
       let bt = UIButton()
        bt.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.7)
        bt.setImage(#imageLiteral(resourceName: "dropPinIcon"), for: .normal)
        bt.titleLabel?.textColor = .white
        bt.setTitle("Drop Pin", for: .normal)
        return bt
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
//        contentView.addSubview(addressLabel)
//        addressLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(contentView.snp.top)
//            make.trailing.equalTo(contentView.snp.trailing)
//            make.bottom.equalTo(contentView.snp.bottom)
//            make.width.equalTo(contentView).multipliedBy(0.9)
//        }
//
        contentView.addSubview(selectLocationButton)
        selectLocationButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)            
        }
    }
        

    


}

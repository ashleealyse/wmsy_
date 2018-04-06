//
//  WhimColorViewTableViewCell.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimColorViewTableViewCell: UITableViewCell {
    
    lazy var colorView: UIView = {
       let cV = UIView()
        cV.backgroundColor = Stylesheet.Colors.WMSYImperial
        return cV
    }()
    
    lazy var createWhimLabel: UILabel = {
       let cWL = UILabel()
        cWL.textColor = .white
        cWL.textAlignment = .center
        cWL.text = "Create A Whim"
        cWL.font = UIFont(name: "Helvetica", size: 35)
        return cWL
    }()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpView() {
        setUpColoredView()
        setUpCreatWhimLabel()
        contentView.addBorders(edges: .bottom, color: .white)
    }
    
    func setUpColoredView() {
        contentView.addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
            make.height.equalTo(64)
        }
    }
    
    func setUpCreatWhimLabel() {
        contentView.addSubview(createWhimLabel)
        createWhimLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(colorView)
            make.bottom.equalTo(colorView).inset(8)
        }
    }

}

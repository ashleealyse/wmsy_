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
    
    lazy var colorView: UIImageView = {
       let cV = UIImageView()
        cV.image = #imageLiteral(resourceName: "purpleGradient")
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
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "dismissIcon"), for: .normal)
        return btn
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
        setUpDismissButton()
    }
    
    func setUpColoredView() {
        addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(116)
        }
    }
    
    func setUpCreatWhimLabel() {
        addSubview(createWhimLabel)
        createWhimLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(colorView)
        }
    }
    
    func setUpDismissButton() {
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(colorView.snp.top).offset(5)
            make.leading.equalTo(colorView.snp.leading).offset(5)
        }
    }

}

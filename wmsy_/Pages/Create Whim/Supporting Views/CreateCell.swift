//
//  CreateCell.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class CreateCell: UITableViewCell {
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = WmsyColors.darkPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.imageView?.clipsToBounds = true
        //button.clipsToBounds = true//
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    
    
    func commonInit(){
        selectionStyle = .none
        backgroundColor = .systemGray6
        addSubviews(subviews: [createButton])
        constrainToAllSides(item: createButton, sides: ([.top], [createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)]))
        
        
        //createButton.layer.cornerRadius = 10
    }

}

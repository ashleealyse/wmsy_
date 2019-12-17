//
//  FilterCell.swift
//  wmsy_
//
//  Created by Lynk on 12/5/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


class FilterCell: UICollectionViewCell {
    lazy var filterIcon: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubviews(subviews: [filterIcon])
        constrainToAllSides(item: filterIcon, sides: ([.top,.bottom,.left,.right],[]))
    }
  
    
}

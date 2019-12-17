//
//  CategoryCell.swift
//  wmsy_
//
//  Created by Lynk on 12/16/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    let filter = FilterBar(frame: .zero, withClear: false)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        filter.backgroundColor = .systemGray6
        addSubviews(subviews: [filter])
        constrainToAllSides(item: filter, sides: ([.top,.bottom,.left,.right],[]))
    }
    
}

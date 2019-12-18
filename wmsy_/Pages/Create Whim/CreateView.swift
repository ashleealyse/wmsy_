//
//  CreateView.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit



class CreateView: UIView {
    lazy var form: UITableView = {
        let tv = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tv.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        tv.register(LocationCell.self, forCellReuseIdentifier: "LocationCell")
        tv.register(TimeCell.self, forCellReuseIdentifier: "TimeCell")
        tv.register(CreateCell.self, forCellReuseIdentifier: "CreateCell")
        tv.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tv.backgroundColor = .systemGray6
        tv.bounces = false
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    lazy var header: UIView = {
        let v = UIView()
        v.backgroundColor = WmsyColors.headerPurple
        return v
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Create Whim"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .systemGray6
        addSubviews(subviews: [form])
        //header.addSubviews(subviews: [title])
        //constrainHeader()
        constainForm()
        //constrainTitle()
    }
    

    func resignKey() {
        
    }
    
    func constainForm() {
        constrainToAllSides(item: form, sides: ([.bottom,.left,.right,.top],[]))
    }
}

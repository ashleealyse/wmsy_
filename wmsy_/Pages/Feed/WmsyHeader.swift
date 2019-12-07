//
//  WmsyHeader.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit



class WmsyHeader: UIView {
    
    lazy var wmsyLogo: UILabel = {
        let label = UILabel()
        label.text = "wmsy"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return label
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
        button.setImage(UIImage(systemName: "house", withConfiguration: largeConfiguration)?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
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
        addSubview(wmsyLogo)
        wmsyLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wmsyLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wmsyLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 11),
            wmsyLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11)
        ])
    }
}

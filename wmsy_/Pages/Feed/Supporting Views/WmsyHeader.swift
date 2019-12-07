//
//  WmsyHeader.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit




protocol wmsyHeaderDelegate: AnyObject {
    func filterSelected()
}


class WmsyHeader: UIView {
    
    lazy var wmsyLogo: UILabel = {
        let label = UILabel()
        label.text = "WMSY"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(textStyle: .body, scale: .large), forImageIn: .normal)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.addTarget(self, action: #selector(filterSelected), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: wmsyHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubviews()
        constrainLogo()
        constrainFilterButton()
    }
    
    
    @objc func filterSelected() {
        delegate?.filterSelected()
    }
    
    
    
    
    
    
    
    
    func addSubviews() {
        addSubview(wmsyLogo)
        addSubview(filterButton)
    }
    
    
    
    func constrainLogo() {
        wmsyLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           // wmsyLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wmsyLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            wmsyLogo.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func constrainFilterButton() {
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   //filterButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filterButton.centerYAnchor.constraint(equalTo: wmsyLogo.centerYAnchor),
                   filterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11)
               ])
    }
    
}

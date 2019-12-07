//
//  FilterBar.swift
//  wmsy_
//
//  Created by Lynk on 12/5/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


class FilterBar: UIView {
    
    
    lazy var filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        cv.bounces = false
        return cv
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
        backgroundColor = .red
        addSubview(filterCollection)
        filterCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterCollection.topAnchor.constraint(equalTo: topAnchor),
            filterCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollection.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

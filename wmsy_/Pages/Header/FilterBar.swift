//
//  FilterBar.swift
//  wmsy_
//
//  Created by Lynk on 12/5/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

protocol FilterBarDelegate: AnyObject {
    func clearPressed()
    func filterPressed(filterPressed: String)
    func createWhimPressed()
}


class FilterBar: UIView {
    
    
    lazy var filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        cv.bounces = false
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
        return button
    }()
    
    
    weak var delegate: FilterBarDelegate?
    
    init(frame: CGRect, withClear: Bool) {
        super.init(frame: frame)
        commonInit(withClear: withClear)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(withClear: true)
    }
    
    
    
    
    func commonInit(withClear: Bool) {
        filterCollection.backgroundColor = withClear ? WmsyColors.headerPurple : .clear
        backgroundColor = withClear ? WmsyColors.headerPurple : .clear
        isOpaque = false
        let subviews = withClear ? [filterCollection,clearButton] : [filterCollection]
        addSubviews(subviews: subviews)
        constrainFilterCollection(withClear: withClear)
        if withClear { constrainClearButton() }
    }
    
    
    
    @objc func clearPressed() {
        delegate?.clearPressed()
    }
    
    
    
    func constrainFilterCollection(withClear: Bool) {
        let anchor = withClear ? clearButton.leadingAnchor : trailingAnchor
        NSLayoutConstraint.activate([
            filterCollection.topAnchor.constraint(equalTo: topAnchor),
            filterCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollection.trailingAnchor.constraint(equalTo: anchor, constant: -5)
        ])
    }
    
    func constrainClearButton() {
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            clearButton.widthAnchor.constraint(equalToConstant: 44),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5)
        ])
    }
}





extension FilterBar: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 10
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
          
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 44, height: 33)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterPressed(filterPressed: indexPath.row.description)
    }
}

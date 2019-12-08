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
}


class FilterBar: UIView {
    
    
    lazy var filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        cv.bounces = false
        cv.backgroundColor = .purple
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
        return button
    }()
    
    
    weak var delegate: FilterBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    
    func commonInit() {
        backgroundColor = .purple
        addSubviews(subviews: [filterCollection,clearButton])
        constrainFilterCollection()
        constrainClearButton()
    }
    
    
    
    @objc func clearPressed() {
        delegate?.clearPressed()
    }
    
    
    
    func constrainFilterCollection() {
        NSLayoutConstraint.activate([
            filterCollection.topAnchor.constraint(equalTo: topAnchor),
            filterCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollection.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -5)
        ])
    }
    
    func constrainClearButton() {
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
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
          return CGSize(width: 33, height: 22)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterPressed(filterPressed: indexPath.row.description)
    }
}

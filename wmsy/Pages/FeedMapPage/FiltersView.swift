//
//  FiltersView.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FiltersView: UIView {

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // Category Label
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
                lb.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        lb.text = "Filter Whims"
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    // Category Collection View
    lazy var categoriesCV: UICollectionView = {
        //        let categoriesCV = UICollectionView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.01
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.07 / numberOfCells, height: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.07)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing * 4
        layout.minimumInteritemSpacing = cellSpacing
        let categoriesCV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        //        categoriesCV.backgroundColor = .white
        categoriesCV.register(WhimCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCategoryCell")
        categoriesCV.showsHorizontalScrollIndicator = false
        categoriesCV.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        return categoriesCV
    }()
    
    // button to show full map view, to the left of the categories CV
    lazy var mapOrFeedButton: UIButton = {
        let button = UIButton()
       button.setTitle("View", for: .normal)
        button.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        return button
    }()
    
    // segmented control for distances 0.5 mile, 1.0 miles, 5 miles, 10 miles
    lazy var distanceSegmentedControl: UISegmentedControl = {
       let sc = UISegmentedControl()
        sc.backgroundColor = Stylesheet.Colors.WMSYDeepViolet
        return sc
    }()
    
    // setup custom view
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .yellow
        setUpViews()
    }
    
    private func setUpViews() {
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        
        
        addSubview(categoriesCV)
        categoriesCV.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.width.equalTo(screenWidth * 0.8)
//            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        
        addSubview(mapOrFeedButton)
        mapOrFeedButton.snp.makeConstraints { (make) in
            make.leading.equalTo(categoriesCV.snp.trailing).offset(5)
            make.top.equalTo(categoriesCV.snp.top)
            make.bottom.equalTo(categoriesCV.snp.bottom)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
        addSubview(distanceSegmentedControl)
        distanceSegmentedControl.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.top.equalTo(categoriesCV.snp.bottom).offset(5)
//            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        
    }
}

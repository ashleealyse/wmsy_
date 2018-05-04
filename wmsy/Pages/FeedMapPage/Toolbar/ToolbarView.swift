//
//  ToolbarView.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ToolbarView: UIView {
    
    // MARK: - Properties
    let pullButton = UIButton()
    let categoryLabel = UILabel()
    let clearFiltersButton = UIButton()
    let distanceSegmentedControl = UISegmentedControl()
    lazy var categoryCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        addSubviews()
        customizeViews()
        constrainSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(pullButton)
        self.addSubview(categoryLabel)
        self.addSubview(clearFiltersButton)
        self.addSubview(distanceSegmentedControl)
        self.addSubview(categoryCV)
    }
    private func customizeViews() {
        self.customizePullButton()
        self.customizeCategoryLabel()
        self.customizeClearFiltersButton()
        self.customizeDistanceSegmentedControl()
        self.customizeCategoryCV()
    }
    private func constrainSubviews() {
        self.constrainPullButton()
        self.constrainCategoryLabel()
        self.constrainClearFiltersButton()
        self.constrainDistanceSegmentedControl()
        self.constrainCategoryCV()
    }
    
    // MARK: - PullButton
    private func customizePullButton() {
        pullButton.setImage(#imageLiteral(resourceName: "pullBarIcon"), for: .normal)
    }
    private func constrainPullButton() {
        pullButton.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        }
    }
    
    // MARK: - CategoryLabel
    private func customizeCategoryLabel() {
        categoryLabel.backgroundColor = .white
        categoryLabel.text = "Filter Whims"
        categoryLabel.font = UIFont.systemFont(ofSize: 15)
        categoryLabel.textColor = Stylesheet.Colors.WMSYKSUPurple
    }
    private func constrainCategoryLabel() {
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pullButton.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self).inset(5)
            make.height.equalTo(self).multipliedBy(0.2)
        }
    }
    
    // MARK: - ClearFiltersButton
    private func customizeClearFiltersButton() {
        clearFiltersButton.setTitle("Clear", for: .normal)
        clearFiltersButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
    }
    private func constrainClearFiltersButton() {
        clearFiltersButton.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryCV.snp.trailing).offset(5)
            make.top.bottom.equalTo(categoryCV)
            make.trailing.equalTo(self).inset(5)
        }
    }
    
    // MARK: - DistanceSegmentedControl
    private func customizeDistanceSegmentedControl() {
        distanceSegmentedControl.backgroundColor = Stylesheet.Colors.WMSYDeepViolet
    }
    private func constrainDistanceSegmentedControl() {
        distanceSegmentedControl.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.top.equalTo(categoryCV.snp.bottom).offset(5)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }

    }
    
    // MARK: - CategoryCV
    private func customizeCategoryCV() {
        categoryCV.register(WhimCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCategoryCell")
    }
    private func constrainCategoryCV() {
        categoryCV.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(5)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.4)
        }
    }
}

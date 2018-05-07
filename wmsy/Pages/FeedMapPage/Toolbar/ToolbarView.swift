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
    lazy var categoryCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    let allFiltersButton = UIButton()
    let distanceLabel = UILabel()
    let distanceSegmentedControl = UISegmentedControl()
    
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
        self.addBorders(edges: .top, color: Stylesheet.Colors.WMSYImperial)
        self.addBorders(edges: .bottom, color: Stylesheet.Colors.WMSYImperial)
        self.backgroundColor = .white
    }
    
    private func setupViews() {
        addSubviews()
        customizeViews()
        constrainSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(pullButton)
        self.addSubview(categoryLabel)
        self.addSubview(categoryCV)
        self.addSubview(allFiltersButton)
        self.addSubview(distanceLabel)
        self.addSubview(distanceSegmentedControl)
    }
    private func customizeViews() {
        self.customizePullButton()
        self.customizeCategoryLabel()
        self.customizeCategoryCV()
        self.customizeAllFiltersButton()
        self.customizeDistanceLabel()
        self.customizeDistanceSegmentedControl()
    }
    private func constrainSubviews() {
        self.constrainPullButton()
        self.constrainCategoryLabel()
        self.constrainCategoryCV()
        self.constrainAllFiltersButton()
        self.constrainDistanceLabel()
        self.constrainDistanceSegmentedControl()
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
            make.top.equalTo(pullButton.snp.bottom)
            make.leading.trailing.equalTo(self).inset(5)
            make.height.equalTo(self).multipliedBy(0.125)
        }
    }
    
    
    // MARK: - CategoryCV
    private func customizeCategoryCV() {
        categoryCV.register(WhimCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCategoryCell")
        categoryCV.allowsMultipleSelection = true
        categoryCV.backgroundColor = .clear
        categoryCV.showsHorizontalScrollIndicator = false
    }
    private func constrainCategoryCV() {
        categoryCV.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.leading.equalTo(self).offset(5)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.25)
        }
    }
    
    // MARK: - AllFiltersButton
    private func customizeAllFiltersButton() {
        allFiltersButton.setTitle("All", for: .normal)
        allFiltersButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
        allFiltersButton.addBorders(edges: .all, color: Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8))
    }
    private func constrainAllFiltersButton() {
        allFiltersButton.snp.makeConstraints { (make) in
            make.leading.equalTo(categoryCV.snp.trailing).offset(5)
            make.top.bottom.equalTo(categoryCV)
            make.trailing.equalTo(self).inset(5)
        }
    }
    
    // MARK: - DistanceLabel
    private func customizeDistanceLabel() {
        distanceLabel.text = "Miles"
        distanceLabel.font = UIFont.systemFont(ofSize: 15)
        distanceLabel.textColor = Stylesheet.Colors.WMSYKSUPurple
    }
    private func constrainDistanceLabel() {
        distanceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryCV.snp.bottom)
            make.leading.trailing.equalTo(self).inset(5)
            make.height.equalTo(self).multipliedBy(0.125)
        }
    }
    
    // MARK: - DistanceSegmentedControl
    private func customizeDistanceSegmentedControl() {
        distanceSegmentedControl.tintColor = Stylesheet.Colors.WMSYDeepViolet
        distanceSegmentedControl.insertSegment(withTitle: "1", at: 0, animated: false)
        distanceSegmentedControl.insertSegment(withTitle: "5", at: 1, animated: false)
        distanceSegmentedControl.insertSegment(withTitle: "10", at: 2, animated: false)
        distanceSegmentedControl.insertSegment(withTitle: "25", at: 3, animated: false)
        distanceSegmentedControl.insertSegment(withTitle: "25+", at: 4, animated: false)
    }
    private func constrainDistanceSegmentedControl() {
        distanceSegmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(distanceLabel.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
            make.bottom.equalTo(self)
        }
    }
}

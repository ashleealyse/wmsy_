//
//  ExpandedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class ExpandedFeedCellView: UIView {
    
    lazy var postDescriptionTF: UITextView = {
        let tF = UITextView()
        tF.font = UIFont(name: "Helvetica", size: 16.0)
        tF.isEditable = false
        tF.isSelectable = false
        return tF
    }()
    
    lazy var showOnMapButton: UIButton = {
        let mapButton = UIButton()
//        mapButton.setImage(#imageLiteral(resourceName: "mapIcon"), for: .normal)
        mapButton.setTitle("Map", for: .normal)
        mapButton.layer.borderColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8).cgColor
        mapButton.layer.borderWidth = 1.0
        mapButton.setTitleColor(Stylesheet.Colors.WMSYKSUPurple, for: .normal)
//        mapButton.titleLabel?.textColor = .black
        return mapButton
    }()
    
    lazy var interestedButton: UIButton = {
        let interestButton = UIButton()
//        interestButton.layer.borderWidth = 1.0
//        interestButton.layer.borderColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8).cgColor
        interestButton.setTitle("Show Interest", for: .normal)
        interestButton.titleLabel?.textColor = .black
        return interestButton
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        setUpPostDescription()
        setUpMapButton()
        setUpInterestButton()
    }
    
    private func setUpPostDescription() {
        addSubview(postDescriptionTF)
        postDescriptionTF.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.65)
        }
    }
    
    private func setUpMapButton() {
        addSubview(showOnMapButton)
        showOnMapButton.snp.makeConstraints { (make) in
            make.top.equalTo(postDescriptionTF.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
    }
    
    private func setUpInterestButton() {
        addSubview(interestedButton)
        interestedButton.snp.makeConstraints { (make) in
            make.top.equalTo(postDescriptionTF.snp.bottom)
            make.leading.equalTo(showOnMapButton.snp.trailing)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
    }

}


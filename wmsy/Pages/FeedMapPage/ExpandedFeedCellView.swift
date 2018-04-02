//
//  ExpandedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

//protocol ExpandedFeedCellViewDelegate: class {
//
//    func showOnMapButtonPressed()
//
//    func interestButtonClicked()
//
//}

class ExpandedFeedCellView: UIView {
    
//    weak var delegate: ExpandedFeedCellViewDelegate?
//    weak var delegate: FeedCellViewDelegate?
    
    lazy var postDescriptionTF: UITextView = {
        let tF = UITextView()
        tF.font = UIFont(name: "Helvetica", size: 16.0)
        tF.isEditable = false
        tF.isSelectable = false
        return tF
    }()
    
    lazy var showOnMapButton: UIButton = {
        let mapButton = UIButton()
        mapButton.setImage(#imageLiteral(resourceName: "mapIcon"), for: .normal)
//        mapButton.addTarget(self, action: #selector(showOnMap), for: .touchUpInside)
        return mapButton
    }()
    
    lazy var interestedButton: UIButton = {
        let interestButton = UIButton()
        interestButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
//        interestButton.addTarget(self, action: #selector(showInterest), for: .touchUpInside)
        return interestButton
    }()
    
    lazy var interestLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Show Interest"
        return lb
    }()
    
//    @objc func showOnMap() {
//        self.delegate?.showOnMapButtonPressed()
//    }
//
//    @objc func showInterest() {
//        self.delegate?.interestButtonClicked()
//    }
    
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
        setUpInterestLabel()
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
            make.leading.equalTo(self.snp.leading).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.width.equalTo(self.snp.width).multipliedBy(0.07)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
    }
    
    private func setUpInterestButton() {
        addSubview(interestedButton)
        interestedButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.width.equalTo(self.snp.width).multipliedBy(0.07)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
    }
    
    private func setUpInterestLabel() {
        addSubview(interestLabel)
        interestLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(interestedButton.snp.leading).offset(-2)
            make.centerY.equalTo(interestedButton.snp.centerY)
        }
    }
}


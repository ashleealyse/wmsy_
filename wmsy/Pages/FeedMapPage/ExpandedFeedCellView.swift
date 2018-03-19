//
//  ExpandedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ExpandedFeedCellView: UIView {
    
    lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "wmsyCategoryIcon")
        image.layer.borderWidth = 1.0
        image.clipsToBounds = true
        return image
    }()
    
    lazy var wmsyTitle: UILabel = {
        let wl = UILabel()
        wl.text = "WMSY Post Title"
        return wl
    }()
    
    lazy var wmsyDescription: UITextView = {
        let wD = UITextView()
        wD.text =  "Anyone down for Ice Cream in SoHo"
        wD.isEditable = false
        wD.isSelectable = false
        return wD
    }()
    
    lazy var showOnMapButton: UIButton = {
        let mapButton = UIButton()
        mapButton.setTitle("Show on Map", for: .normal)
        mapButton.layer.borderWidth = 1.0
        mapButton.setTitleColor(.black, for: .normal)
        mapButton.layer.cornerRadius = 15
        return mapButton
    }()
    
    lazy var interestedButton: UIButton = {
        let interestButton = UIButton()
        interestButton.setTitle("Interested!", for: .normal)
        interestButton.setTitleColor(.black, for: .normal)
        interestButton.layer.borderWidth = 1.0
        interestButton.layer.cornerRadius = 15
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
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setUpUserImage()
        setUpWmsyTitle()
        setUpMapButton()
        setUpInterestButton()
        setUpWmsyDescription()
    }
    
    func setUpUserImage() {
       addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.height.equalTo(userImage.snp.width)
        }
    }
    
    func setUpWmsyTitle() {
      addSubview(wmsyTitle)
        wmsyTitle.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(25)
            make.leading.equalTo(userImage.snp.trailing).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
        }
    }
    
    func setUpWmsyDescription() {
        addSubview(wmsyDescription)
        wmsyDescription.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(showOnMapButton.snp.top).offset(-5)
            make.height.equalTo(self).multipliedBy(0.2)
        }
    }
    
    func setUpMapButton() {
        addSubview(showOnMapButton)
        showOnMapButton.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
        }
    }
    
    func setUpInterestButton() {
        addSubview(interestedButton)
        interestedButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.size.height / 2.0
        
    }

}

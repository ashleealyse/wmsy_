//
//  ExpandedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

//class ExpandedFeedCellView: UIView {
//    
//    lazy var userImage: UIButton = {
//        let imageButton = UIButton()
//        imageButton.setImage(#imageLiteral(resourceName: "Jane"), for: .normal)
//        imageButton.layer.borderWidth = 1.0
//        imageButton.clipsToBounds = true
//        return imageButton
//    }()
//    
//    lazy var wmsyTitle: UILabel = {
//        let wl = UILabel()
//        wl.font = UIFont(name: "AvenirNext-Medium", size: 20.0)
//        wl.numberOfLines = 0
//        return wl
//    }()
//    
//    lazy var wmsyDescription: UITextView = {
//        let wD = UITextView()
//        wD.font = UIFont(name: "AvenirNext-UltraLight", size: 16.0)
//        wD.isEditable = false
//        wD.isSelectable = false
//        return wD
//    }()
//    
//    lazy var showOnMapButton: UIButton = {
//        let mapButton = UIButton()
//        mapButton.setImage(#imageLiteral(resourceName: "mapIcon"), for: .normal)
//        mapButton.setTitleColor(.black, for: .normal)
//        return mapButton
//    }()
//    
//    lazy var interestedButton: UIButton = {
//        let interestButton = UIButton()
//        interestButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
//        interestButton.setTitleColor(.black, for: .normal)
//        return interestButton
//    }()
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//    private func commonInit() {
//        setUpViews()
//    }
//    
//    private func setUpViews() {
//        setUpUserImage()
//        setUpWmsyTitle()
//        setUpMapButton()
//        setUpInterestButton()
//        setUpWmsyDescription()
//    }
//    
//    func setUpUserImage() {
//       addSubview(userImage)
//        userImage.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide).offset(5)
//            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
//            make.height.equalTo(userImage.snp.width)
//        }
//    }
//    
//    func setUpWmsyTitle() {
//      addSubview(wmsyTitle)
//        wmsyTitle.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide).offset(25)
//            make.leading.equalTo(userImage.snp.trailing).offset(5)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
//        }
//    }
//    
//    func setUpWmsyDescription() {
//        addSubview(wmsyDescription)
//        wmsyDescription.snp.makeConstraints { (make) in
//            make.top.equalTo(userImage.snp.bottom).offset(5)
//            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
//            make.bottom.equalTo(showOnMapButton.snp.top).offset(-5)
//            make.height.equalTo(self).multipliedBy(0.3)
//        }
//    }
//    
//    func setUpMapButton() {
//        addSubview(showOnMapButton)
//        showOnMapButton.snp.makeConstraints { (make) in
//            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
//            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
//        }
//    }
//    
//    func setUpInterestButton() {
//        addSubview(interestedButton)
//        interestedButton.snp.makeConstraints { (make) in
//            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
//            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        userImage.layer.cornerRadius = userImage.frame.size.height / 2.0
//        
//    }
//
//}

class ExpandedFeedCellView: UIView {
    
lazy var userImage: UIButton = {
    let imageButton = UIButton()
    imageButton.imageView?.contentMode = .scaleToFill
    imageButton.setImage(#imageLiteral(resourceName: "Jane"), for: .normal)
    imageButton.layer.borderWidth = 1.0
    imageButton.clipsToBounds = true
    return imageButton
}()


lazy var wmsyTitle: UILabel = {
    let wl = UILabel()
    wl.font = UIFont(name: "HelveticaNeue-Light", size: 15)
    wl.numberOfLines = 0
    return wl
}()

lazy var categoryImage: UIImageView = {
    let catImg = UIImageView()
    return catImg
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
    setUpViews()
}

private func setUpViews() {
    setUpUserImage()
    setUpCategoryImage()
    setUpWmsyTitle()
}

func setUpUserImage() {
    addSubview(userImage)
    userImage.snp.makeConstraints { (make) in
        make.top.equalTo(self).offset(5)
        make.leading.equalTo(self).offset(5)
        make.bottom.equalTo(self).offset(-5)
        make.height.equalTo(userImage.snp.width)
        make.width.equalTo(self).multipliedBy(0.1)
    }
}

func setUpWmsyTitle() {
    addSubview(wmsyTitle)
    wmsyTitle.snp.makeConstraints { (make) in
        make.leading.equalTo(userImage.snp.trailing).offset(5)
        make.trailing.equalTo(categoryImage.snp.leading).offset(-5)
        make.centerY.equalTo(userImage.snp.centerY)
    }
}

func setUpCategoryImage() {
    addSubview(categoryImage)
    categoryImage.snp.makeConstraints { (make) in
        make.top.equalTo(self).offset(5)
        make.trailing.equalTo(self).offset(-5)
        make.height.equalTo(self).multipliedBy(0.5)
        make.width.equalTo(self.snp.height).multipliedBy(0.5)
    }
}

override func layoutSubviews() {
    super.layoutSubviews()
    userImage.layer.cornerRadius = userImage.frame.size.height / 2.0
    
}
}

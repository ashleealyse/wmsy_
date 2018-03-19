//
//  CollapsedFeedCellView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CollapsedFeedCellView: UIView {

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
    }
    
    func setUpUserImage() {
      addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.leading.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.height.equalTo(userImage.snp.width)
        }
    }
    
    func setUpWmsyTitle() {
      addSubview(wmsyTitle)
        wmsyTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(25)
            make.leading.equalTo(userImage.snp.trailing).offset(5)
            make.trailing.equalTo(self).offset(-5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.size.height / 2.0
        
    }
    
}

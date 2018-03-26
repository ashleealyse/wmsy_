//
//  MapDetailView.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MapDetailView: UIView {

    lazy var userPicture: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.layer.borderWidth = 1.0
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    lazy var whimTitle: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    lazy var whimDescription: UILabel = {
        let label = UILabel()
        label.text = "description"
        return label
    }()

    lazy var interestedButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.setImage(#imageLiteral(resourceName: "wmsyLogo"), for: .normal)
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.white
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        setUpUserPicture()
        setUpTitle()
        setUpDescription()
    }
    
    private func setUpUserPicture(){
        addSubview(userPicture)
        userPicture.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(5)
            make.width.equalTo(self).multipliedBy(0.2)
            make.height.equalTo(userPicture.snp.width)
            make.top.equalTo(self.snp.top).offset(5)
        }
        
    }
    
    private func setUpTitle(){
        addSubview(whimTitle)
        whimTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(userPicture.snp.trailing).offset(20)
            make.trailing.equalTo(self.snp.trailing)
        }
        
    }
    
    private func setUpDescription(){
        addSubview(whimDescription)
        whimDescription.snp.makeConstraints { (make) in
            make.top.equalTo(whimTitle.snp.bottom).offset(5)
            make.leading.equalTo(userPicture.snp.trailing).offset(20)
            make.trailing.equalTo(self.snp.trailing)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userPicture.layer.cornerRadius = userPicture.frame.size.height / 2.0
    }
}

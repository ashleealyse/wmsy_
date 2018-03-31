//
//  ChatGuestCollectionViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ChatGuestCollectionViewCell: UICollectionViewCell {
    
    lazy var guestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                guestImageView.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
            } else {
                guestImageView.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
            }
        }
    }

    public var highlight = false
    
    private func setupViews(){
        setupGuestImage()
    }
    
    private func addSubViews() {
        addSubview(guestImageView)
    }
    
    private func setupGuestImage(){
  
        guestImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height)
        }
    }
    
    override func layoutSubviews() {
        guestImageView.layer.masksToBounds = true
        guestImageView.layer.cornerRadius = guestImageView.frame.size.height / 2.0
    }
}

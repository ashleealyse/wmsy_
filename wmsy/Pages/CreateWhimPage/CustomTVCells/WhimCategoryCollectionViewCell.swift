//
//  WhimCategoryCollectionViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimCategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.5
//        imageView.clipsToBounds = true
//        imageView.layer.borderColor = Stylesheet.Colors.WMSYKSUPurple.cgColor
//        imageView.layer.borderWidth = 0.5
//        imageView.layer.cornerRadius = imageView.bounds.width / 5.0
        
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
//    
//    public func toggleColor() {
//        switch categoryImage.backgroundColor! {
//        case Stylesheet.Colors.WMSYIsabelline:
//            categoryImage.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
//        case Stylesheet.Colors.WMSYSeaFoamGreen:
//            categoryImage.backgroundColor = Stylesheet.Colors.WMSYIsabelline
//        default:
//            categoryImage.backgroundColor = Stylesheet.Colors.WMSYIsabelline
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
//                categoryImage.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
                categoryImage.alpha = 1.0
            } else {
//                categoryImage.backgroundColor = .clear
                categoryImage.alpha = 0.5
            }
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        categoryImage.layer.cornerRadius = categoryImage.frame.size.width / 2.0
//    }
    
    private func setupViews(){
        setupCategoryImage()
    }
    
    private func addSubViews() {
        addSubview(categoryImage)
    }
    
    private func setupCategoryImage(){
        categoryImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height)
//            make.height.equalTo(snp.height).multipliedBy(0.5)
        }
    }
    
    
}

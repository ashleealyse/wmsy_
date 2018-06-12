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
        imageView.layer.masksToBounds = true
        imageView.alpha = 0.8
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
                categoryImage.alpha = 1.0
                categoryImage.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.2)
            } else {
                categoryImage.alpha = 0.8
                categoryImage.backgroundColor = .clear
            }
        }
    }
    
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
        }
    }
    
    
}

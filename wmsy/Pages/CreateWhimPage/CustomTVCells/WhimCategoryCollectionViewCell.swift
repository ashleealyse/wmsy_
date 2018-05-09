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
    
    var categoryImageView = UIImageView()
    
    // used to not cut off a piece of the icon when the cells are rounded
    // TODO: calculate proper value to be the right inset for different size cells and devices
    let amountToInsetImage: CGFloat = 5
    
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
        self.backgroundColor = .clear
    }
    private func setupViews() {
        self.addSubviews()
        self.customizeSubviews()
        self.constrainSubviews()
    }
    private func addSubviews() {
        self.contentView.addSubview(categoryImageView)
    }
    private func customizeSubviews() {
        self.customizeCategoryImageView()
    }
    private func constrainSubviews() {
        self.constrainCategoryImageView()
    }
    
    // MARK: - CategoryImageView
    private func customizeCategoryImageView() {
        categoryImageView.backgroundColor = .clear
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.layer.masksToBounds = true
        categoryImageView.alpha = 0.8
    }
    private func constrainCategoryImageView(){
        categoryImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(amountToInsetImage)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                categoryImageView.alpha = 1.0
                self.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.2)
            } else {
                categoryImageView.alpha = 0.8
                self.backgroundColor = .clear
            }
        }
    }
}

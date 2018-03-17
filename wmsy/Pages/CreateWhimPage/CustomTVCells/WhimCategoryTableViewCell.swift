//
//  WhimCategoryTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimCategoryTableViewCell: UITableViewCell {

    // Category Label
    lazy var categoryLabel: UILabel = {
       let lb = UILabel()
        lb.backgroundColor = Stylesheet.Colors.WMSYAshGrey
        lb.text = "Choose a Category: "
        return lb
    }()

    
    // Category Collection View
    lazy var categoriesCV: UICollectionView = {
//        let categoriesCV = UICollectionView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.01
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.1 / numberOfCells, height: screenHeight * 0.10)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let categoriesCV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        categoriesCV.backgroundColor = .white
        categoriesCV.register(WhimCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoriesCV.showsHorizontalScrollIndicator = false
        categoriesCV.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        return categoriesCV
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
//            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        contentView.addSubview(categoriesCV)
        categoriesCV.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.height.equalTo(categoryLabel.snp.height).multipliedBy(2.0)
        }
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

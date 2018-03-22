//
//  HostChatView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class HostChatView: UIView {

    // Collection View of Interested Guests
    lazy var interestedGuestsCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.01
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.09 / numberOfCells, height: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.09)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        
        let interestedGuestsCV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        
        interestedGuestsCV.register(ChatGuestCollectionViewCell.self, forCellWithReuseIdentifier: "ChatGuestCell")
        interestedGuestsCV.showsHorizontalScrollIndicator = false
        interestedGuestsCV.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        return interestedGuestsCV
    }()
    
    // Hidden Profile/Invite Cell that exposes when you Select an Interested Guest
    
    // Chat Room TableView
    
    // Chat Message TextField
    
    // Send Chat Message Button
    
    // Go On A Whim Button
    
    // setup custom view
    
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
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(interestedGuestsCV)
    }
    
    private func setupConstraints() {
        interestedGuestsCV.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            let screenHeight = UIScreen.main.bounds.height
            make.height.equalTo(screenHeight * 0.07)
        }
    }
}

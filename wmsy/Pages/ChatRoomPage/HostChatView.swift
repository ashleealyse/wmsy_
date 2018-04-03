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
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

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
    lazy var hiddenBio: UIView = {
       let view = UIView()
        view.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        return view
    }()
    
    // Chat Room TableView
    lazy var chatTableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        return tbv
    }()
    
    // Chat Message TextField
    lazy var chatTextField: UITextField = {
       let tf = UITextField()
        tf.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        tf.placeholder = "Send a message"
        return tf
    }()
    
    // Send Chat Message Button
    lazy var sendChatButton: UIButton = {
       let bt = UIButton()
        bt.layer.backgroundColor = Stylesheet.Colors.WMSYPastelBlue.cgColor
        bt.setTitle("Send", for: .normal)
        return bt
    }()
    
    // Go On A Whim Button
    lazy var goOnAWhimButton: UIButton = {
        let bt = UIButton()
        bt.layer.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen.cgColor
        bt.setTitle("Go On A Whim", for: .normal)
        return bt
    }()
    
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
        addSubview(hiddenBio)
        addSubview(goOnAWhimButton)
        addSubview(chatTextField)
        addSubview(sendChatButton)
        addSubview(chatTableView)
    }
    
    private func setupConstraints() {
        interestedGuestsCV.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(screenHeight * 0.07)
        }
    
        hiddenBio.snp.makeConstraints { (make) in
            make.top.equalTo(interestedGuestsCV.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(screenHeight * 0.1)
        }
        
        chatTableView.snp.makeConstraints { (make) in
            make.top.equalTo(hiddenBio.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(chatTextField.snp.top)
        }
        
        chatTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.width.equalTo(screenWidth * 0.75)
            make.height.equalTo(screenHeight * 0.07)
        }
    
        sendChatButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.width.equalTo(screenWidth * 0.2)
            make.height.equalTo(screenHeight * 0.07)
        }
    
//        goOnAWhimButton.snp.makeConstraints { (make) in
//            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
//            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
//            make.height.equalTo(screenHeight * 0.07)
//
//        }
    
    }
}

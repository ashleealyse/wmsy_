//
//  MenuCollectionViewWrapper.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class MenuCollectionViewWrapper: UIView {
    static let pageOneIdentifier = "ProfileView"
    static let pageTwoIdentifier = "WhimsView"
    
    public lazy var menuPagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.register(MenuProfileView.self, forCellWithReuseIdentifier: MenuCollectionViewWrapper.pageOneIdentifier)
        cv.register(MenuWhimsView.self, forCellWithReuseIdentifier: MenuCollectionViewWrapper.pageTwoIdentifier)
        return cv
    }()
    private var persistentMenuFooter = UIView()
    private var leftDot = UIView()
    private var rightDot = UIView()
    
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
        backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        setupViews()
        layoutStuff()
    }
    
    
    
    
    private func setupViews() {
        setupMenuPagesCollectionView()
        setupPersistentMenuFooter()
        setupLeftDot()
        setupRightDot()
    }
    private func setupMenuPagesCollectionView() {
        addSubview(menuPagesCollectionView)
        menuPagesCollectionView.backgroundColor = UIColor.clear
        menuPagesCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    private let bottomViewHeight: CGFloat = 100
    private func setupPersistentMenuFooter() {
        persistentMenuFooter.isUserInteractionEnabled = false
        addSubview(persistentMenuFooter)
        persistentMenuFooter.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(bottomViewHeight)
        }
    }
    private func setupLeftDot() {
        leftDot.clipsToBounds = true
        leftDot.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        leftDot.layer.cornerRadius = (bottomViewHeight * 0.10) / 2
        persistentMenuFooter.addSubview(leftDot)
        leftDot.snp.makeConstraints { (make) in
            make.centerY.equalTo(persistentMenuFooter)
            make.height.width.equalTo(bottomViewHeight * 0.10)
            make.centerX.equalTo(persistentMenuFooter).offset(-10)
        }
    }
    private func setupRightDot() {
        rightDot.clipsToBounds = true
        rightDot.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        rightDot.layer.cornerRadius = (bottomViewHeight * 0.10) / 2
        persistentMenuFooter.addSubview(rightDot)
        rightDot.snp.makeConstraints { (make) in
            make.centerY.equalTo(persistentMenuFooter)
            make.height.width.equalTo(bottomViewHeight * 0.10)
            make.centerX.equalTo(persistentMenuFooter).offset(10)
        }
    }
    // MARK: - helper functions

    public func layoutStuff() {
    }
}

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
    static let pageThreeIdentifier = "ChatView"
    
    public lazy var menuPagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.register(MenuProfileView.self, forCellWithReuseIdentifier: MenuCollectionViewWrapper.pageOneIdentifier)
        cv.register(MenuWhimsView.self, forCellWithReuseIdentifier: MenuCollectionViewWrapper.pageTwoIdentifier)
        cv.register(MenuChatView.self, forCellWithReuseIdentifier: MenuCollectionViewWrapper.pageThreeIdentifier)
        return cv
    }()
    
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
    }
    private func setupMenuPagesCollectionView() {
        addSubview(menuPagesCollectionView)
        menuPagesCollectionView.backgroundColor = UIColor.clear
        menuPagesCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    // MARK: - helper functions
    
    public func layoutStuff() {
    }
    

}

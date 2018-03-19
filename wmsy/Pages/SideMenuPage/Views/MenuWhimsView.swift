//
//  MenuWhimsView.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MenuWhimsView: UICollectionViewCell {
    
    static let headerIdentifier = "WhimsHeader"
    static let cellIdentifier = "WhimsCell"
    public var whimsTableView = UITableView()
    
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
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        setupWhimsTableView()
    }
    private func setupWhimsTableView() {
        whimsTableView.separatorStyle = .none
        whimsTableView.contentInsetAdjustmentBehavior = .never
        whimsTableView.backgroundColor = .clear
        whimsTableView.register(MenuWhimsHeader.self, forHeaderFooterViewReuseIdentifier: MenuWhimsView.headerIdentifier)
        whimsTableView.register(MenuWhimsCell.self, forCellReuseIdentifier: MenuWhimsView.cellIdentifier)
        whimsTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        whimsTableView.rowHeight = UITableViewAutomaticDimension
        whimsTableView.estimatedSectionHeaderHeight = 100
        whimsTableView.estimatedRowHeight = 100
        whimsTableView.bounces = false
        contentView.addSubview(whimsTableView)
        whimsTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
}

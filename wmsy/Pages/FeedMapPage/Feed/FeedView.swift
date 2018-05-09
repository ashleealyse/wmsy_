//
//  FeedView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class FeedView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: UITableViewStyle.plain)
        return tv
    }()
    let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    private func setupViews() {
        self.addSubviews()
        self.customizeSubviews()
        self.constrainSubviews()
    }
    private func addSubviews() {
        self.addSubview(tableView)
        self.tableView.addSubview(refreshControl)
    }
    private func customizeSubviews() {
        self.customizeTableView()
        self.customizeRefreshControl()
    }
    private func constrainSubviews() {
        self.constrainTableView()
        self.constrainRefreshControl()
    }
    
    // MARK: - TableView
    private func customizeTableView() {
        tableView.backgroundColor = Stylesheet.Colors.WMSYGray
        tableView.register(FeedCell2.self, forCellReuseIdentifier: "WhimFeedCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    private func constrainTableView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - RefreshControl
    private func customizeRefreshControl() {
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        refreshControl.attributedTitle = NSAttributedString.init(string: "loading whims", attributes: attributes)
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = Stylesheet.Colors.WMSYImperial
    }
    private func constrainRefreshControl() {
        // not needed?
    }
}

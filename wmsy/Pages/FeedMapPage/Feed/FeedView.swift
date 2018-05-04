//
//  FeedView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


// Only holds a tableView for now
// made to easily extend this view later
class FeedView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRect.zero, style: .grouped)
        return tv
    }()
    
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
    }
    private func customizeSubviews() {
        self.customizeTableView()
    }
    private func constrainSubviews() {
        self.constrainTableView()
    }
    
    // MARK: - TableView
    private func customizeTableView() {
        tableView.backgroundColor = Stylesheet.Colors.WMSYGray
        tableView.register(FeedCell.self, forCellReuseIdentifier: "WhimFeedCell")
    }
    private func constrainTableView() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

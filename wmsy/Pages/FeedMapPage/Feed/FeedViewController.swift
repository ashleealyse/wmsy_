//
//  FeedViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedViewControllerDelegate: class {
    
}

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    let refreshControl = UIRefreshControl()
    var delegate: FeedViewControllerDelegate?
    
    private var whims = [Whim]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(feedView)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.refreshControl?.addSubview(refreshControl)
        feedView.tableView.refreshControl?.sendSubview(toBack: refreshControl)
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        refreshControl.attributedTitle = NSAttributedString.init(string: "loading whims", attributes: attributes)
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
        refreshControl.addTarget(self, action: #selector(refreshControlDragged), for: UIControlEvents.valueChanged)
        feedView.tableView.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
    }
    @objc private func refreshControlDragged() {
        if !feedView.tableView.isDragging {
            refreshData()
        }
    }
    private func refreshData() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.refreshControl.blink()
            self.refreshControl.endRefreshing()
        }
    }
    public func updateWhimsTo(_ whims: [Whim]) {
        refreshControl.endRefreshing()
        guard self.whims != whims else {return}
        self.whims = whims
        feedView.tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
        cell.backgroundColor = .red
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            refreshData()
        }
    }
}

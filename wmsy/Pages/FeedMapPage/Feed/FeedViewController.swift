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
    }
    
    public func setWhimsTo(_ whims: [Whim]) {
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
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    
}

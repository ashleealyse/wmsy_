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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(feedView)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

//
//  FeedMapParentViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FeedMapParentViewController: MenuedViewController {
    
    let feedVC = FeedViewController()
    let toolbarVC = ToolbarViewController()
    let mapVC = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add(feedVC)
        self.add(toolbarVC)
        self.add(mapVC)
        
        feedVC.delegate = self
        toolbarVC.delegate = self
        mapVC.delegate = self
    }
}

extension FeedMapParentViewController: FeedViewControllerDelegate {
    
}

extension FeedMapParentViewController: ToolbarViewControllerDelegate {
    
}

extension FeedMapParentViewController: MapViewControllerDelegate {
    
}

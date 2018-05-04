//
//  FeedMapParentViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FeedMapParentViewController: MenuedViewController {
    
    let navBarVC = NavBarViewController()
    let feedVC = FeedViewController()
    let toolbarVC = ToolbarViewController()
    let mapVC = MapViewController()
    
    let toolbarHeight: CGFloat = 90.0
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add(navBarVC)
        self.add(feedVC)
        self.add(toolbarVC)
        self.add(mapVC)
        
        self.layoutNavBarVC()
        self.layoutFeedVC()
        
        feedVC.delegate = self
        toolbarVC.delegate = self
        mapVC.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helper Functions
    private func layoutNavBarVC() {
        navBarVC.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.height.equalTo(64)
        }
    }
    private func layoutFeedVC() {
        feedVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(navBarVC.view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(toolbarHeight)
        }
    }
    
}

extension FeedMapParentViewController: FeedViewControllerDelegate {
    
}

extension FeedMapParentViewController: ToolbarViewControllerDelegate {
    func toolbar(_ toolbar: ToolbarViewController, selectedCategory category: Category) {
        
    }
    func toolbar(_ toolbar: ToolbarViewController, deselectedCategory category: Category) {
        
    }
}

extension FeedMapParentViewController: MapViewControllerDelegate {
    
}

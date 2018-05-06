//
//  FeedMapParentViewController+FeedViewControllerDelegate.swift
//  wmsy
//
//  Created by C4Q on 5/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension FeedMapParentViewController: FeedViewControllerDelegate {
    func feedView(_ feedView: FeedViewController, requestingUpdate request: Bool) {
        loadData()
    }
}

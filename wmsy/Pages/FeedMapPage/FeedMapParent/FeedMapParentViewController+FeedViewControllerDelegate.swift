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
        self.loadData()
    }
    func feedView(_ feedView: FeedViewController, tappedUserProfile userID: String) {
        self.showUserProfile(userID)
    }
    func feedView(_ feedView: FeedViewController, tappedInterestButton whim: Whim) {
        self.toggleInterest(whim)
    }
    func feedView(_ feedView: FeedViewController, tappedShowOnMapButton whim: Whim) {
        self.showOnMap(whim)
    }
}

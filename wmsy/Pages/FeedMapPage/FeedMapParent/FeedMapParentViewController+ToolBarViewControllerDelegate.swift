//
//  FeedMapParentViewController+ToolBarViewControllerDelegate.swift
//  wmsy
//
//  Created by C4Q on 5/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension FeedMapParentViewController: ToolbarViewControllerDelegate {
    func toolbar(_ toolbar: ToolbarViewController, selectedCategories categories: [Category]) {
        categories.forEach{selectedCategories.insert($0)}
        self.feedVC.updateWhimsTo(displayingWhims)
        self.mapVC.updateWhimsTo(displayingWhims)
    }
    func toolbar(_ toolbar: ToolbarViewController, deselectedCategories categories: [Category]) {
        categories.forEach{selectedCategories.remove($0)}
        self.feedVC.updateWhimsTo(displayingWhims)
        self.mapVC.updateWhimsTo(displayingWhims)
    }
}


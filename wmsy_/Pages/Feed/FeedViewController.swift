//
//  FeedViewController.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feed = FeedView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(feed)
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
         return UIStatusBarStyle.lightContent
    }

}

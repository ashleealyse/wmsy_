//
//  NavBarViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NavBarViewController: UIViewController {
    
    let navView = NavView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(navView)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        navView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}
extension FeedMapVC: MenuDataSimpleNotificationDelegate {
    func newNotification() {
        // add any code that should trigger when there's been a notification here
        navView.leftButton.imageView?.tintColor = .red
    }
}


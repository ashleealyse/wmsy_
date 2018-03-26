//
//  GuestProfileVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class GuestProfileVC: UIViewController {

    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(profileView)
        profileView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    
    
}

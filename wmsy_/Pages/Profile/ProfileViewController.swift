//
//  ProfileViewController.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let profile = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(subviews: [profile])
        view.constrainToAllSides(item: profile, sides: [.top,.right,.left,.bottom])
        
        
    }
    
    
    
}

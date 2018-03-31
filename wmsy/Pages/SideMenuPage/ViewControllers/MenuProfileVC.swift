//
//  MenuProfileVC.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuProfileVC: UIViewController {
    
    let profileView = MenuProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    public func configureWith(appUser: AppUser) {
        guard let url = URL(string: appUser.photoID) else {return}
        print(appUser.photoID)
        profileView.profileImageView.kf.setImage(with: url)
        profileView.bioTextView.text = appUser.bio
        profileView.nameLabel.text = appUser.name
    }
}

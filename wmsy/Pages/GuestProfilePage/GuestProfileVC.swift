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
    }

    override func viewWillAppear(_ animated: Bool) {
                profileView.profileImageView.layer.cornerRadius = 75
    }
        @objc func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissButtonClicked()
    }
    
    public func configure(with user: AppUser) {
        let url = URL(string: user.photoID)
        profileView.profileImageView.kf.setImage(with: url)
        profileView.bioLabel.text = user.bio
        profileView.nameLabel.text = user.name
    }
    
    
}

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
    private let placeholderText = "Describe Yourself"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        view.backgroundColor = .white
        //        profileView.bioTextView.textColor = UIColor.lightGray
        //        profileView.bioTextView.delegate = self
        profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        profileView.editBioButton.addTarget(self, action: #selector(editBio), for: .touchUpInside)
    }
    @objc func editBio() {
        let editBioAlert = Alert.create(withTitle: "Edit My Bio", andMessage: "", withPreferredStyle: .alert)
        editBioAlert.addTextField { (textField: UITextField) in
            textField.autocorrectionType = .default
            textField.keyboardType = .default
            textField.placeholder = "Tell us about yourself"
            textField.clearButtonMode = .whileEditing
            textField.text = self.profileView.bioTextView.text
        }
        Alert.addAction(withTitle: "Done", style: .default, andHandler: { (action) -> Void in
            let textField = editBioAlert.textFields![0]
            self.profileView.bioTextView.text = textField.text
            DBService.manager.updateBio(textField.text!, forUser: AppUser.currentAppUser!)
            self.profileView.bioTextView.resignFirstResponder()
        }, to: editBioAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: { (action) -> Void in
            self.profileView.bioTextView.resignFirstResponder()
        }, to: editBioAlert)
        self.present(editBioAlert, animated: true, completion: nil)
    }

    
    
    
    
    
    public func configureWith(appUser: AppUser) {
        guard let url = URL(string: appUser.photoID) else {return}
        print(appUser.photoID)
        profileView.profileImageView.kf.setImage(with: url)
        profileView.bioTextView.text = appUser.bio
        profileView.nameLabel.text = appUser.name
    }
}

//
//  LoginVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        view.addSubview(loginView)
    }
}



extension LoginVC: loginViewDelegate{
    func loginButtonPressed() {
        let loginManager = LoginManager()
        loginManager.logIn( readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let vc = FeedMapVC()
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
}

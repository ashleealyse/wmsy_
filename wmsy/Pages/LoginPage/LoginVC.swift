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

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        var name: String?
        var id: String?
        var birthday: String?
        var profilePictureUrl: String?
        init(rawResponse: Any?) {
            guard let response = rawResponse as? Dictionary<String, Any> else {
                return
            }
            
            if let name = response["name"] as? String {
                self.name = name
            }
            
            if let id = response["id"] as? String {
                self.id = id
            }
            
            if let birthday = response["birthday"] as? String {
                self.birthday = birthday
            }
            
            if let picture = response["picture"] as? Dictionary<String, Any> {
                
                if let data = picture["data"] as? Dictionary<String, Any> {
                    if let url = data["url"] as? String {
                        self.profilePictureUrl = url
                    }
                }
            }
        }
    }
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, birthday, picture"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}


class LoginVC: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        view.addSubview(loginView)
    }
    let connection = GraphRequestConnection()
    
}



extension LoginVC: loginViewDelegate {
    func loginButtonPressed() {
        let loginManager = LoginManager()
        loginManager.logIn( readPermissions: [.publicProfile,.userBirthday], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.connection.add(MyProfileRequest()) { response, result in
                    switch result {
                    case .success(let response):
                        print("Custom Graph Request Succeeded: \(response)")
                        print("My facebook id is \(response.id!)")
                        print("My name is \(response.name!)")
                        print("My birthday is \(response.birthday!)")
                        print("My picture URL is \(response.profilePictureUrl ?? "none")")
                        let vc = FeedMapVC()
                        let nav = UINavigationController(rootViewController: vc)
                        self.present(nav, animated: true, completion: nil)
                    case .failed(let error):
                        print("Custom Graph Request Failed: \(error)")
                    }
                }
                self.connection.start()
            }
        }
    }
}

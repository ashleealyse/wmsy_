//
//  LoginView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


protocol loginViewDelegate: class {
    func loginButtonPressed()
    
}

class LoginView: UIView {
    
    weak var delegate: loginViewDelegate?
    
    lazy var facebookButton : UIButton = {
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0,y: 0,width: 180, height: 40)
        myLoginButton.center = self.center
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        return myLoginButton
    }()
    
    @objc func loginButtonClicked(){
        self.delegate?.loginButtonPressed()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        backgroundColor = .white
        setButton()
    }
    
    private func setButton(){
        self.addSubview(facebookButton)
    }
    
    
    
    
}

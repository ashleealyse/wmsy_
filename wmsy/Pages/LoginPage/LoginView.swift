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
        myLoginButton.backgroundColor = Stylesheet.Colors.WMSYDeepViolet
        myLoginButton.frame = CGRect(x: 0,y: 0,width: 180, height: 40)
        myLoginButton.center = self.center
        myLoginButton.setTitle("Login with facebook", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        return myLoginButton
    }()
    
    lazy var colorView: UIView = {
        let cv = UIView()
        cv.backgroundColor = Stylesheet.Colors.WMSYPastelBlue.withAlphaComponent(0.8)
        return cv
    }()
    
    lazy var wmsyLogo: UIImageView = {
       let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "wmsyLogo")
        return logo
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
        setUpColorView()
        setUpWmsyLogo()
    }
    
    private func setButton(){
        self.addSubview(facebookButton)
        facebookButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.snp.height).multipliedBy(0.10)
        }
    }
    
    func setUpColorView() {
        self.addSubview(colorView)
        colorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(facebookButton.snp.top)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    func setUpWmsyLogo() {
        self.addSubview(wmsyLogo)
        wmsyLogo.snp.makeConstraints { (make) in
            make.centerY.equalTo(colorView.snp.centerY)
            make.centerX.equalTo(colorView.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.30)
            make.height.equalTo(self.snp.width).multipliedBy(0.30)
        }
    }
    
}

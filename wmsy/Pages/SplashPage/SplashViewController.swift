//
//  SplashViewController.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var splashView = SplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(splashView)
        scaled()
    }
    
    func scaled() {
        
        UIView.animate(withDuration: 3.0, animations: {
            self.splashView.logo.layer.transform = CATransform3DMakeScale(8, 8, 8)
        }, completion: { _ in
            UIView.animate(withDuration: 3.0, animations: {
                self.splashView.logo.layer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
            })
        })
        
    }

}

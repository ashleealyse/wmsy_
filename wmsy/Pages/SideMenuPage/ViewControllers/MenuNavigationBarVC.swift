//
//  MenuNavigationBarVC.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import SnapKit

protocol MenuNavigationBarVCDelegate: class {
    func feedButtonPressed() -> Void
}

class MenuNavigationBarVC: UIViewController {
    
    let feedButton = UIButton()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedButton)
        view.addSubview(titleLabel)
        view.backgroundColor = Stylesheet.Colors.WMSYImperial
        view.addBorders(edges: .bottom, color: .white)

        feedButton.setImage(#imageLiteral(resourceName: "whiteForwardIcon"), for: .normal)
        titleLabel.text = "My Whims"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        feedButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
        }
        
    }
    
}

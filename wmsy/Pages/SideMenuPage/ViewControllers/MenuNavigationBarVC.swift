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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedButton)
        view.backgroundColor = Stylesheet.Colors.WMSYDeepViolet
        
        
//        feedButton.setTitleColor(.white, for: .normal)
//        feedButton.setTitle("Go to Feed", for: .normal)
        feedButton.setImage(#imageLiteral(resourceName: "whiteForwardIcon"), for: .normal)
        
        feedButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(64)
        }
    }
}

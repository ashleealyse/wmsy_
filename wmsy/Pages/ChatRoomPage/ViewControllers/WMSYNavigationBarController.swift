//
//  WMSYNavigationBarController.swift
//  wmsy
//
//  Created by C4Q on 4/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class WMSYNavigationBarController: UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
    }
}



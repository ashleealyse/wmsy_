//
//  SplashView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class SplashView: UIView {
    
    lazy var coloredView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.21, green:0.02, blue:0.41, alpha:1.0).withAlphaComponent(0.6)
        return view
    }()
    
    lazy var logo: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = #imageLiteral(resourceName: "wmsyLogo")
        return logoImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .white
        commonInit()
    }
    
    func commonInit() {
        setUpColoredBackground()
        setUpLogo()
    }
    
    func setUpColoredBackground() {
        addSubview(coloredView)
        coloredView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setUpLogo() {
        addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(logo.snp.width)
        }
    }
    
}

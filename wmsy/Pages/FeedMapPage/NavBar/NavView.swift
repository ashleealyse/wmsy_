//
//  NavView.swift
//  wmsy
//
//  Created by C4Q on 4/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NavView: UIView {
    public var leftButton = UIButton()
    public var rightButton = UIButton()
    public var titleButton = UIButton()
    
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
        setupViews()
        self.addBorders(edges: .bottom, color: Stylesheet.Colors.WMSYImperial)
    }
    
    private func setupViews() {
        self.addSubviews()
        self.customizeSubviews()
        self.constrainSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(titleButton)
    }
    private func customizeSubviews() {
        self.customizeLeftButton()
        self.customizeRightButton()
        self.customizeTitleButton()
    }
    private func constrainSubviews() {
        self.constrainLeftButton()
        self.constrainRightButton()
        self.constrainTitleButton()
    }
    
    // MARK: - LeftButton
    private func customizeLeftButton() {
        let tintedImage = (#imageLiteral(resourceName: "feedIcon-1")).withRenderingMode(.alwaysTemplate)
        leftButton.setImage(tintedImage, for: .normal)
        leftButton.imageView?.tintColor = Stylesheet.Colors.WMSYKSUPurple
        leftButton.imageView?.contentMode = .scaleAspectFit
    }
    private func constrainLeftButton() {
        leftButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self).inset(12)
            make.bottom.equalTo(self).inset(8)
            make.top.equalTo(self).inset(28)
        }
    }
    
    // MARK: - RightButton
    private func customizeRightButton() {
        let tintedImage = (#imageLiteral(resourceName: "addIcon")).withRenderingMode(.alwaysTemplate)
        rightButton.setImage(tintedImage, for: .normal)
        rightButton.imageView?.tintColor = Stylesheet.Colors.WMSYKSUPurple
        rightButton.imageView?.contentMode = .scaleAspectFit
    }
    private func constrainRightButton() {
        rightButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).inset(12)
            make.bottom.equalTo(self).inset(8)
            make.top.equalTo(self).inset(28)
        }
    }
    
    // MARK: - TitleButton
    private func customizeTitleButton() {
        self.addSubview(titleButton)
        titleButton.setTitle("wmsy", for: .normal)
        titleButton.setTitleColor(.black, for: .normal)
    }
    private func constrainTitleButton() {
        titleButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).inset(8)
        }
    }
    
}

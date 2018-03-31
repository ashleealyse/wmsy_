//
//  PopUpTextView.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PopUpTextView: UIView {
    
    let backgroundButton = UIButton()
    let textInput = UITextView()
    let saveButton = UIButton()
    let scrapButton = UIButton()
    
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
    }
    
    private func setupViews() {
        setupBackgroundButton()
        setupTextInput()
    }
    private func setupBackgroundButton() {
        addSubview(backgroundButton)
        backgroundButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    private func setupTextInput() {
        addSubview(textInput)
        textInput.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.4)
            make.center.equalTo(self)
        }
    }
    
    
}

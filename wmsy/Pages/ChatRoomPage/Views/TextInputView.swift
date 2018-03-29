//
//  TextInputView.swift
//  wmsy
//
//  Created by C4Q on 3/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AutoHeightTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds, textContainer: nil)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeight), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    @objc func updateHeight() {
        // trigger your animation here
        print("some stuff")
        UIView.animate(withDuration: 0.2) {
         var newFrame = self.frame
         
         let fixedWidth = self.frame.size.width
         let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
         
         newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
         self.frame = newFrame
        }
        
        // suggest searching stackoverflow for "uiview animatewithduration" for frame-based animation
        // or "animate change in intrinisic size" to learn about a more elgant solution :)
    }
}

class TextInputView: UIView {
    
    public let messageTextView = AutoHeightTextView()
    public let sendButton = UIButton()
    
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
        backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        setupViews()
    }
    
    private func setupViews() {
        setupMessageTextView()
        setupSendButton()
    }
    
    private func setupMessageTextView() {
        messageTextView.backgroundColor = .clear
        messageTextView.font = UIFont.systemFont(ofSize: 20)
        messageTextView.textColor = UIColor.lightGray
        messageTextView.backgroundColor = .clear
        messageTextView.text = "adlfjhaldksfjn"
        addSubview(messageTextView)
        messageTextView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self)
        }
    }
    private func setupSendButton() {
        sendButton.setTitle("SEND", for: .normal)
        sendButton.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        addSubview(sendButton)
        sendButton.snp.makeConstraints { (make) in
            make.leading.equalTo(messageTextView.snp.trailing)
            make.bottom.trailing.equalTo(self)
            make.width.height.equalTo(64)
        }
    }
    
}

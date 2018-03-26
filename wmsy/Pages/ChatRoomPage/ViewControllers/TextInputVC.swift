//
//  TextInputVC.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol TextInputVCDelegate: class {
    func send(message: String) -> Void
}

class TextInputVC: UIViewController {
    
    public let messageTextField = UITextView()
    
    public weak var delegate: TextInputVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(messageTextField)
        
        messageTextField.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.height.equalTo(100)
        }
        messageTextField.delegate = self
        messageTextField.backgroundColor = .red
        
//        var amountOfLinesToBeShown:CGFloat = 6
//        var maxHeight:CGFloat = messageTextField.font!.lineHeight * amountOfLinesToBeShown
//        messageTextField.sizeThatFits(CGSize.init(width: messageTextField.frame.width, height: messageTextField.frame.height))
    }
}

extension TextInputVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            let text = textView.text!
            textView.text = ""
            if !text.isEmpty {delegate?.send(message: text)}
            return false
        }
        return true
    }
}


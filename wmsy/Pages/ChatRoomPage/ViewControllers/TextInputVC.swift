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
    
    private let textInputView = TextInputView()
    
    private let placeholderText = "Say Something..."
    
    public weak var delegate: TextInputVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textInputView)
        
        textInputView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        textInputView.messageTextView.delegate = self
        textInputView.messageTextView.text = placeholderText
        textInputView.messageTextView.textColor = UIColor.lightGray

        textInputView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
    }
    
    @objc func sendMessage() {
        if textInputView.messageTextView.text != placeholderText {
            textInputView.messageTextView.resignFirstResponder()
            let text = textInputView.messageTextView.text!
            textInputView.messageTextView.text = ""
            if !text.isEmpty {delegate?.send(message: text)}
        } else {
            print("placeholder text")
        }
    }
}

extension TextInputVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textInputView.messageTextView.text != placeholderText {
            if(text == "\n") {
                textView.resignFirstResponder()
                let text = textView.text!
                textView.text = ""
                if !text.isEmpty {delegate?.send(message: text)}
                return false
            }            
        }
        print("no text input")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
//            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}


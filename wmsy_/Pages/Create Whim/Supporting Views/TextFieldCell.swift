//
//  TextFieldCell.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ex: Join Hiking Group"
        tf.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        tf.backgroundColor = .systemGray6
        tf.returnKeyType = .done
        return tf
    }()
    
    lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Ex: Join us in our weekly meeting of the hike team! explore some hiking shit"
        tv.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        tv.backgroundColor = .systemGray6
        tv.textColor = .lightGray
        tv.returnKeyType = .done
        return tv
    }()
    

    
    func setup(isTitle:Bool) {
        selectionStyle = .none
        backgroundColor = .systemGray6
        let inputObject = isTitle ? titleTextField : descriptionTextView
        var constraints: [NSLayoutConstraint] = [inputObject.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11), inputObject.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11), inputObject.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)]
        if !isTitle { constraints.append(inputObject.topAnchor.constraint(equalTo: topAnchor, constant: 11))}
        
        
        addSubviews(subviews: [inputObject])
        constrainToAllSides(item: inputObject, sides: ([],constraints))
        addBottomBorderWithColor(color: .systemGray, width: 1)
    }

    
}

//
//  UIViewExtention.swift
//  wmsy_
//
//  Created by Lynk on 12/8/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit



extension UIView {
     func addSubviews(subviews:[UIView]) {
        subviews.forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

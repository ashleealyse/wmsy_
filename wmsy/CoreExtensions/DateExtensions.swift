//
//  DateExtensions.swift
//  wmsy
//
//  Created by C4Q on 5/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension Date{
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}

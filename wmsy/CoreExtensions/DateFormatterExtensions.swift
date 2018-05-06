//
//  DateFormatterExtensions.swift
//  wmsy
//
//  Created by C4Q on 5/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension DateFormatter {
    //    "March 21, 2018 at 3:11:50 PM EDT"
    static let wmsyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.timeStyle = .long
        formatter.dateStyle = .long
        return formatter
    }()
}

//
//  Interest.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct Interest: Codable {
    let whimID: String
    let userID: String
    var inChat: Bool
    
    static let singlePendingInterest = Interest(whimID: "ewu12341yr", userID: "fuqyefiuqyweg12312", inChat: false)
    static let singleAcceptedInterest = Interest(whimID: "sjdafh23839ye", userID: "adfiuu238762", inChat: true)
}

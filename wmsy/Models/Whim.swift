//
//  Whim.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct Whim: Codable {
    let id: String
    let title: String
    let description: String
    let hostID: String
    let location: String
    let postedTimestamp: Int
    let visibilityDuration: Int
    let finalized: Bool
    let whimChats: [Message]
    
    static let firstWhim = Whim(id: "nbjaeksd345", title: "First Whim", description: "Join me on my first whim", hostID: "gaefnsdk345", location: "2 Rivington Street, New York, NY", postedTimestamp: 4567898765, visibilityDuration: 56788765, finalized: false, whimChats: [Message.singleMessage])
}

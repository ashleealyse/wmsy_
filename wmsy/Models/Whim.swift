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
}

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
    let category: String
    let title: String
    let description: String
    let hostID: String
    let location: String
    let duration: Int
    let finalized: Bool
    let timestamp: String
    let whimChats: [Message]
    
//    static let firstWhim = Whim(id: "nbjaeksd345", category: "Arts", title: "First Whim", description: "Join me on my first whim", hostID: "gaefnsdk345", location: "2 Rivington Street, New York, NY", duration: 56788765, finalized: false, timestamp: "456789965")
    
    static let firstWhim = Whim(id: "ghjkg", category: "Arts", title: "my first whime", description: "do stuff, good stuff", hostID: "huibjdw", location: "the park or something", duration: 3, finalized: false, timestamp: "456789", whimChats: [])
    
    
    
    init(id: String, category: String, title: String, description: String, hostID: String, location: String, duration: Int, finalized: Bool, timestamp: String, whimChats: [Message]) {
        self.init(id: id,
                  category: category,
                  title: title,
                  description: description,
                  hostID: hostID,
                  location: location,
                  duration: duration,
                  finalized: finalized,
                  timestamp: timestamp,
                  whimChats: whimChats)
    }
    
    
    // convenience init
    init(id: String, category: String, title: String, description: String, hostID: String, location: String, duration: Int) {
        self.init(id: id, category: category, title: title, description: description, hostID: hostID, location: location, duration: duration)
    }
    
    
}

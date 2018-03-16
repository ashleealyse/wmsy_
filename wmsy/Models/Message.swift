//
//  Message.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

enum MessageType: String, Codable {
    case chat
    case notification
    case button
}

struct Message: Codable {
    let whimID: String
    let messageID: String
    let senderID: String?
    let timestamp: Int
    let messageType: MessageType
    let messageBody: String
    
static let singleMessage = Message.init(whimID: "GPL13D5", messageID: "H923BB4", senderID: "TT09SC43", timestamp: 45378542, messageType: .chat, messageBody: "Yay Ice Cream")
}

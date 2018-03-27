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
    let timestamp: String
    let messageType: MessageType
    let messageBody: String
    
    init(whimID: String, messageID: String, senderID: String?, timestamp: String = "\(Date().timeIntervalSince1970)", messageType: MessageType, messageBody: String) {
        self.whimID = whimID
        self.messageID = messageID
        self.senderID = senderID
        self.timestamp = timestamp
        self.messageType = messageType
        self.messageBody = messageBody
    }
    
    init?(fromDict messageDict: [String:Any]) {
        guard
            let senderID = messageDict["userID"] as? String,
            let messageBody = messageDict["body"] as? String,
            let timestamp = messageDict["timestamp"] as? String,
            let messageType = messageDict["type"] as? String,
            let whimID = messageDict["whimID"] as? String,
            let messageID = messageDict["messageID"] as? String
            else {
                return nil
        }
        self.whimID = whimID
        self.messageID = messageID
        self.senderID = senderID
        self.timestamp = timestamp
        self.messageType = MessageType(rawValue: messageType) ?? .chat
        self.messageBody = messageBody
    }
    
static let singleMessage = Message.init(whimID: "GPL13D5", messageID: "H923BB4", senderID: "TT09SC43", timestamp: "45378542", messageType: .chat, messageBody: "Yay Ice Cream")
}

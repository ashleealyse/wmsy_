//
//  DBService+Message.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension DBService {
    public func addMessage(text: String, ofType type: MessageType = .chat, fromUserID userID: String? = nil , toWhim whim: Whim) {
        let messageRef = messagesRef.child(whim.id).childByAutoId()
        let whimRef = whimsRef.child(whim.id).child("messages").child(messagesRef.key)
        whimRef.setValue([])
        
        let message = Message(whimID: whim.id, messageID: messageRef.key, senderID: userID, messageType: type, messageBody: text)
        messagesRef.setValue([
            "userId": message.senderID ?? "",
            "body": message.messageBody,
            "timestamp": message.timestamp,
            "type": message.messageType.rawValue
            ])
    }
    
    
}

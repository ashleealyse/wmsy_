//
//  DBService+Message.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    public func addMessage(text: String, ofType type: MessageType = .chat, fromUserID userID: String? , toWhim whim: Whim) {
        let messageRef = messagesRef.child(whim.id).childByAutoId()
        let whimRef = whimsRef.child(whim.id).child("messages").child(messageRef.key)
        whimRef.setValue(true)
        
        let message = Message(whimID: whim.id, messageID: messageRef.key, senderID: userID, messageType: type, messageBody: text)
        messageRef.setValue([
            "userID": message.senderID ?? "",
            "body": message.messageBody,
            "timestamp": message.timestamp,
            "type": message.messageType.rawValue
            ])
    }
    public func getAllMessages(forWhim whim: Whim,
                               completion: @escaping ([Message]) -> Void) {
        let ref = DBService.manager.messagesRef.child(whim.id)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var messages = [Message]()
            for child in snapshot.children {
                guard
                    let snapshot = child as? DataSnapshot,
                    var messageDict = snapshot.value as? [String: Any]
                    else{
                   print("error hereeeee")
                        return
                }
                messageDict["whimID"] = whim.id
                messageDict["messageID"] = snapshot.key
                if let message = Message(fromDict: messageDict) {
                    messages.append(message)
                } else {
                    print("error making message in getAllMessages(forWhim:)")
                }
            }
            completion(messages)
        }
    }
//    public func getMessages
}

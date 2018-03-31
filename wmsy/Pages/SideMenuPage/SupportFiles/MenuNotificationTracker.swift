//
//  MenuData+NotificationTracker.swift
//  wmsy
//
//  Created by C4Q on 3/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol MenuNotificationTrackerDelegate: class {
    func hostChatNotification(inWhim whimID: String) -> Void
    func guestChatNotification(inWhim whimID: String) -> Void
    func interestNotification(forWhim whimID: String) -> Void
    func newUserInterested(inWhim whimID: String) -> Void
}


class MenuNotificationTracker {
    private init() {
        guard let user = AppUser.currentAppUser else {
            print("current user hasn't been set yet")
            fatalError()
        }
        let userInterests = user.interests.filter{!$0.inChat}.map{$0.whimID}
        let guestWhims = user.interests.filter{$0.inChat}.map{$0.whimID}
        let hostWhims = user.hostedWhims.map{$0.id}
        for whimID in userInterests {
            userInterestsHandle[whimID] = DBService.manager.usersRef.child(user.userID).child("interests").child(whimID)
            userInterestsHandle[whimID]!.observe(.value, with: { (snapshot) in
                if let inChat = snapshot.value as? Bool,
                    inChat {
                self.delegate?.interestNotification(forWhim: whimID)
                self.userInterestsHandle[whimID]?.removeAllObservers()
                self.userInterestsHandle[whimID] = nil
                } else {
                    print("no")
                }
            })
        }
        for whimID in guestWhims {
            guestChatsHandle[whimID] = DBService.manager.messagesRef.child(whimID)
            guestChatsHandle[whimID]!.observe(.value, with: { (snapshot) in
                self.delegate?.guestChatNotification(inWhim: whimID)
            })
        }
        for whimID in hostWhims {
            hostChatHandle[whimID] = DBService.manager.messagesRef.child(whimID)
            hostChatHandle[whimID]!.observe(.value, with: { (snapshot) in
                self.delegate?.hostChatNotification(inWhim: whimID)
            })
            guestInterestedHandle[whimID] = DBService.manager.interestsRef.child(whimID)
            guestInterestedHandle[whimID]?.observe(.value, with: { (snapshot) in
                self.delegate?.newUserInterested(inWhim: whimID)
            })
        }
        delegate = MenuData.manager
    }
    static let manager = MenuNotificationTracker()
    
    // listen if youre allowed in a chat
//    listen if youre removed from a chat
//    listen if youve received any new messages
    private weak var delegate: MenuNotificationTrackerDelegate?
    private var userInterestsHandle = [String: DatabaseReference]()
    private var guestChatsHandle = [String: DatabaseReference]()
    private var hostChatHandle = [String: DatabaseReference]()
    private var guestInterestedHandle = [String: DatabaseReference]()
    private func clearObservers() {
        userInterestsHandle.values.forEach{$0.removeAllObservers()}
        guestChatsHandle.values.forEach{$0.removeAllObservers()}
        hostChatHandle.values.forEach{$0.removeAllObservers()}
        guestInterestedHandle.values.forEach{$0.removeAllObservers()}
    }
    public func whimChatOpen(_ whim: Whim) {
        if let handle = guestChatsHandle[whim.id] {
            handle.removeAllObservers()
        } else if let handle = hostChatHandle[whim.id] {
            handle.removeAllObservers()
        }
    }
    public func whimChatClosed(_ whim: Whim) {
        if let handle = guestChatsHandle[whim.id] {
            handle.observe(.value, with: { (snapshot) in
                self.delegate?.guestChatNotification(inWhim: whim.id)
            })
        } else if let handle = hostChatHandle[whim.id] {
            handle.observe(.value, with: { (snapshot) in
                self.delegate?.guestChatNotification(inWhim: whim.id)
            })
        }
    }
//    public func setToChatOpen(forWhim: Whim) {
//        clearObservers()
//    }
}

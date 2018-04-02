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
    
    func currentUserInterested(inWhim whimID: String) -> Void
    func currentUserNoLongerInterested(inWhim whimID: String) -> Void
    func currentUserAllowedInChat(forWhim whimID: String) -> Void
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
//        for whimID in userInterests {
//            userInterestsHandle[whimID] = DBService.manager.usersRef.child(user.userID).child("interests").child(whimID)
//            userInterestsHandle[whimID]!.observe(.value, with: { (snapshot) in
//                if let inChat = snapshot.value as? Bool,
//                    inChat {
//                self.delegate?.interestNotification(forWhim: whimID)
//                self.userInterestsHandle[whimID]?.removeAllObservers()
//                self.userInterestsHandle[whimID] = nil
//                } else {
//                    print("no")
//                }
//            })
//        }
//        for whimID in guestWhims {
//            guestChatsHandle[whimID] = DBService.manager.messagesRef.child(whimID)
//            guestChatsHandle[whimID]!.observe(.value, with: { (snapshot) in
//                self.delegate?.guestChatNotification(inWhim: whimID)
//            })
//        }
//        for whimID in hostWhims {
//            hostChatHandle[whimID] = DBService.manager.messagesRef.child(whimID)
//            hostChatHandle[whimID]!.observe(.value, with: { (snapshot) in
//                self.delegate?.hostChatNotification(inWhim: whimID)
//            })
//            guestInterestedHandle[whimID] = DBService.manager.interestsRef.child(whimID)
//            guestInterestedHandle[whimID]?.observe(.value, with: { (snapshot) in
//                self.delegate?.newUserInterested(inWhim: whimID)
//            })
//        }
//        hookUpUserInterestsHandle()
//        hookUpUserNoLongerInterestedHandle()
    }
    static let manager = MenuNotificationTracker()
    
//    listen if youre allowed in a chat
//    listen if youre removed from a chat
//    listen if youve received any new messages
    public weak var delegate: MenuNotificationTrackerDelegate?
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
    
    // Current User Has shown interest in something
    private var hookedUpCurrentUserIsInterested = false
    private var currentUserInterestedInNewWhimHandle: DatabaseReference!
    private func hookUpUserInterestsHandle(forUser user: AppUser) {
        currentUserInterestedInNewWhimHandle = DBService.manager.usersRef.child(user.userID).child("interests")
        currentUserInterestedInNewWhimHandle.observe(.childAdded) { (snapshot) in
            guard let _ = snapshot.value as? Bool else {
                    
                print("user interest not properly created from firebase")
                fatalError()
            }
//            let interest = Interest(whimID: snapshot.key, userID: user.userID, inChat: false)
//            AppUser.currentAppUser?.interests.append(interest)
            AppUser.currentAppUser!.interests.forEach{print($0.whimID)}
            self.addInGuestChatHandle(forWhim: snapshot.key)
            self.delegate?.currentUserInterested(inWhim: snapshot.key)
        }
    }
    
    // Current User has removed interest in something
    private var hookedUpCurrentUserNoLongerInterested = false
    private var currentUserNoLongerInterestedHandle: DatabaseReference!
    private func hookUpUserNoLongerInterestedHandle(forUser user: AppUser) {
        currentUserNoLongerInterestedHandle = DBService.manager.usersRef.child(user.userID).child("interests")
        currentUserNoLongerInterestedHandle.observe(.childRemoved) { (snapshot) in
            guard let _ = snapshot.value as? Bool else{
                
                print("user interest not properly created from firebase")
                fatalError()
            }
//            guard let index = AppUser.currentAppUser?.interests.index(where: {$0.whimID == snapshot.key}) else {
//                print("current user didnt have this interest")
//                AppUser.currentAppUser!.interests.forEach{print($0.whimID)}
//                fatalError()
//            }
//            AppUser.currentAppUser?.interests.remove(at: index)
            self.delegate?.currentUserNoLongerInterested(inWhim: snapshot.key)
            self.removeInGuestChatHandle(forWhim: snapshot.key)
        }
        print("should be second")
    }
    
    // Current user allowed in a chat
    private var currentUserAllowedInChatHandle = [String: DatabaseReference]()
    private func hookUpUserAllowedInChatHandle(forUser user: AppUser) {
        let userInterests = user.interests.filter{!$0.inChat}.map{$0.whimID}
        for whimID in userInterests {
            addInGuestChatHandle(forWhim: whimID)
        }
    }
    private func addInGuestChatHandle(forWhim whimID: String) {
        guard let user = AppUser.currentAppUser else {
            print("no user right now")
            fatalError()
        }
        currentUserAllowedInChatHandle[whimID] = DBService.manager.usersRef.child(user.userID).child("interests").child(whimID)
        currentUserAllowedInChatHandle[whimID]!.observe(.value, with: { (snapshot) in
            if let inChat = snapshot.value as? Bool,
                inChat {
                guard let index = AppUser.currentAppUser?.interests.index(where: {$0.whimID == snapshot.key}) else {
                    print("current user didnt have this interest")
                    fatalError()
                }
                AppUser.currentAppUser?.interests[index].inChat = true
                self.delegate?.currentUserAllowedInChat(forWhim: whimID)
                self.removeInGuestChatHandle(forWhim: whimID)
            } else {
                print("no")
            }
        })
    }
    private func removeInGuestChatHandle(forWhim whimID: String) {
        self.currentUserAllowedInChatHandle[whimID]?.removeAllObservers()
        self.currentUserAllowedInChatHandle[whimID] = nil
    }
    
    
    // callback just in case something asynchrounous is needed
    public func setupListeners(forUser user: AppUser, completion: @escaping () -> Void) {
        hookUpUserInterestsHandle(forUser: user)
        hookUpUserNoLongerInterestedHandle(forUser: user)
        hookUpUserAllowedInChatHandle(forUser: user)
        
        completion()
    }
}

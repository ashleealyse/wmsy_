//
//  MenuData.swift
//  wmsy
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

// TODO: add a way to connect to a guest chat to forcably kick them out of that VC if the user has been removed from the whim
//protocol GuestChat: class {
//    func gotKickedOut
//}

protocol MenuDataSimpleNotificationDelegate: class {
    func newNotification() -> Void
}

protocol MenuDataDelegate: class {
    func receivedUpdate() -> Void
    func reconfigure() -> Void
}

class MenuData {
    private init() {
        // TODO: get all the stuff from online
        // TODO: setup listeners here
    }
    static let manager = MenuData()
    
    public weak var delegate: MenuDataDelegate?
    public weak var simpleListener: MenuDataSimpleNotificationDelegate?
    
    public var currentPage = 1
    public var hostedWhims = [(whim: Whim, hasNotification: Bool)]()
    public var guestWhims = [(whim: Whim, hasNotification: Bool)]()
    public var pendingInterests = [Interest]()
    
    public func configureInitialData(forUser user: AppUser,
                                     completion: @escaping () -> Void) {
        hostedWhims = user.hostedWhims.map{($0, false)}
        pendingInterests = user.interests.filter{!$0.inChat}
        let guestWhimIDs = user.interests.filter{$0.inChat}.map{$0.whimID}
        DBService.manager.getWhims(fromList: guestWhimIDs) { (whims) in
            self.guestWhims = whims.map{($0, false)}
//            let _ = MenuNotificationTracker.manager
//            MenuNotificationTracker.manager.configure()
            completion()
//            MenuNotificationTracker.manager.delegate = self
        }
    }
    public func interestAccepted(_ whimID: String) {
        guard let index = pendingInterests.index(where: {$0.whimID == whimID}) else {return}
        pendingInterests.remove(at: index)
        DBService.manager.getWhim(fromID: whimID) { (whim) in
            if let whim = whim {
                self.guestWhims.append((whim: whim, hasNotification: true))
                self.delegate?.reconfigure()
            }
        }
    }
}

extension MenuData: MenuNotificationTrackerDelegate {
    
    func currentUserInterested(inWhim whimID: String)   {
        print("interested in whim: \(whimID)")
        print("should show up in menu")
        guard let user = AppUser.currentAppUser else {
            print("no current user")
            fatalError()
        }
        let interest = Interest(whimID: whimID, userID: user.userID, inChat: false)
        pendingInterests.append(interest)
        delegate?.reconfigure()
    }
    func currentUserNoLongerInterested(inWhim whimID: String) {
        print("no longer interested in whim: \(whimID)")
        print("should no longer show up in menu")
        guard let index = pendingInterests.index(where: {$0.whimID == whimID}) else {
            print("interest wasn't pending")
            // whim could be in guest chats list but then it should be removed
            // from that list through the currentUserRemovedFromChat(forWhim:)
            // delegate method
            return
        }
        pendingInterests.remove(at: index)
        delegate?.reconfigure()
    }
    func currentUserAllowedInChat(forWhim whimID: String) {
        print("user had been allowed in whim: \(whimID)")
        print("should be moved from interests to guest chats")
        guard let index = pendingInterests.index(where: {$0.whimID == whimID}) else {
            fatalError()
        }
        pendingInterests.remove(at: index)
        DBService.manager.getWhim(fromID: whimID) { (whim) in
            if let whim = whim {
                self.guestWhims.append((whim: whim, hasNotification: true))
                self.simpleListener?.newNotification()
                self.delegate?.reconfigure()
            }
        }
    }
    
    func currentUserRemovedFromChat(forWhim whimID: String) {
        print("user has been removed from whim: \(whimID)")
        print("should forcably close the chatroom if it is open")
        print("should remove guest chat from list")
        
    }
    
    func currentUserStartedHosting(whim whimID: String) {
        print("user has started hosting whim: \(whimID)")
        print("should add whim to hostedwhims list")
        guard let user = AppUser.currentAppUser else {
            print("no current user")
            fatalError()
        }
        DBService.manager.getWhim(fromID: whimID) { (whim) in
            if let whim = whim {
                self.hostedWhims.append((whim: whim, hasNotification: false))
                self.delegate?.reconfigure()
            }
        }
    }
    func currentUserNoLongerHosting(whim whimID: String) {
        print("user has stopped hosting whim: \(whimID)")
        print("should remove whim from hostedwhims list")
        guard let menuIndex = hostedWhims.index(where: {$0.whim.id == whimID}) else {
            print("hostedWhims list does not have a whim with id: \(whimID)")
            fatalError()
        }
        hostedWhims.remove(at: menuIndex)
        delegate?.reconfigure()
        guard let user = AppUser.currentAppUser else {
            print("no current user")
            fatalError()
        }
        guard let userIndex = user.hostedWhims.index(where: {$0.id == whimID}) else {
            print("user not currently hosting whim with id: \(whimID)")
            fatalError()
        }
        AppUser.currentAppUser?.hostedWhims.remove(at: userIndex)
    }
    
    func currentUserReceivedMessageInHostedWhim(inWhim whimID: String) {
        print("user has received message for whim: \(whimID)")
        print("should show notif in that hosted whim")
        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
            print("hosted whims does not have whim with id: \(whimID)")
            fatalError()
        }
        hostedWhims[index].hasNotification = true
        simpleListener?.newNotification()
        delegate?.reconfigure()
    }
    
    func currentUserReceivedMessageInGuestWhim(inWhim whimID: String) {
        print("user has received message for whim: \(whimID)")
        print("show show notif in that guest whim")
        guard let index = guestWhims.index(where: {$0.whim.id == whimID}) else {
            print("guest whims does not have a whim with id: \(whimID)")
//            fatalError()
            return
        }
        guestWhims[index].hasNotification = true
        simpleListener?.newNotification()
        delegate?.reconfigure()
    }
    
    func otherUserExpressedInterestInHostedWhim(withID whimID: String) {
        print("another user has expressed interest in current user's whim: \(whimID)")
        print("should show notif in that hosted whim")
        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
            print("hosted whims does not have a whim with id: \(whimID)")
            fatalError()
        }
        hostedWhims[index].hasNotification = true
        simpleListener?.newNotification()
        delegate?.reconfigure()
    }
}

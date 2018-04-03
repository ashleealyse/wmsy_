//
//  MenuData.swift
//  wmsy
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

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
    func interestNotification(forWhim whimID: String) {
//        guard let interestIndex = pendingInterests.index(where: {$0.whimID == whimID}) else {
//            return
//        }
//        interestAccepted(whimID)
//        print("interest notif")
    }
    
    func newUserInterested(inWhim whimID: String) {
//        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
//            return
//        }
//        hostedWhims[index].hasNotification = true
//        delegate?.reconfigure()
//        print("newuser notif in \(hostedWhims[index].whim.title)")
    }
    
    func hostChatNotification(inWhim whimID: String) {
//        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
//            return
//        }
//        hostedWhims[index].hasNotification = true
//        delegate?.reconfigure()
//        print("hostchat notif in \(hostedWhims[index].whim.title)")
    }
    
    func guestChatNotification(inWhim whimID: String) {
//        guard let index = guestWhims.index(where: {$0.whim.id == whimID}) else {
//            return
//        }
//        guestWhims[index].hasNotification = true
//        delegate?.reconfigure()
//        print("guest chat notif in \(guestWhims[index].whim.title)")
    }
    
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
        print("user had started hosting whim: \(whimID)")
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
    
    func currentUserReceivedMessageInHostedWhim(inWhim whimID: String) {
        print("user has received message for whim: \(whimID)")
        print("should show notif in that hosted whim")
    }
}

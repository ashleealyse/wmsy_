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
            let _ = MenuNotificationTracker.manager
            completion()
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
        guard let interestIndex = pendingInterests.index(where: {$0.whimID == whimID}) else {
            return
        }
        interestAccepted(whimID)
        print("interest notif")
    }
    
    func newUserInterested(inWhim whimID: String) {
        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
            return
        }
        hostedWhims[index].hasNotification = true
        delegate?.reconfigure()
        print("newuser notif in \(hostedWhims[index].whim.title)")
    }
    
    func hostChatNotification(inWhim whimID: String) {
        guard let index = hostedWhims.index(where: {$0.whim.id == whimID}) else {
            return
        }
        hostedWhims[index].hasNotification = true
        delegate?.reconfigure()
        print("hostchat notif in \(hostedWhims[index].whim.title)")
    }
    
    func guestChatNotification(inWhim whimID: String) {
        guard let index = guestWhims.index(where: {$0.whim.id == whimID}) else {
            return
        }
        guestWhims[index].hasNotification = true
        delegate?.reconfigure()
        print("guest chat notif in \(guestWhims[index].whim.title)")
    }
    
    
}

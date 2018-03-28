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
}

class MenuData {
    private init() {
        // TODO: get all the stuff from online
        // TODO: setup listeners here
    }
    static let manager = MenuData()
    
    public weak var delegate: MenuDataDelegate?
    
    private var currentPage = 1
    private var hostedWhims = [Whim]()
    private var guestWhims = [Whim]()
    private var pendingInterests = [Interest]()
    
    public func configureInitialData(forUser user: AppUser,
                                     completion: @escaping () -> Void) {
        hostedWhims = user.hostedWhims
        pendingInterests = user.interests.filter{!$0.inChat}
        let guestWhimIDs = user.interests.filter{$0.inChat}.map{$0.whimID}
        DBService.manager.getWhims(fromList: guestWhimIDs) { (whims) in
            self.guestWhims = whims
            completion()
        }
    }
}

//
//  AppUser+CurrentUser.swift
//  wmsy
//
//  Created by C4Q on 4/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension AppUser {
    static var currentAppUser: AppUser?
    
    static func configureCurrentAppUser(withUID uid: String, completion: @escaping () -> Void) {
        DBService.manager.getAppUser(fromID: uid, completion: { (appUser) in
            if let appUser = appUser {
                AppUser.currentAppUser = appUser
                print("setup current app user")
                completion()
            } else {
                print("some other error here")
            }
        })
    }
}

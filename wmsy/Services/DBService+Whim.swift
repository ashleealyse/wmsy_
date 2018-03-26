//
//  DBService+Whim.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import FirebaseDatabase
import UIKit

extension DBService {
    public func add(whim: Whim) {
        let appUser = AppUser.singleUser // dummy
        let ref = usersRef.child(appUser.userID)
        ref.setValue([
            "name" : appUser.name,
            "photoID" : appUser.photoID,
            "age" : appUser.age,
            "userID" : appUser.userID,
            "bio" : appUser.bio,
            "badge" : appUser.badge,
            "flags" : appUser.flags
            ])
    }
}

//
//  DBService+AppUser.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

extension DBService {
    public func addAppUser(_ appUser: AppUser, image: UIImage) {
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
     let _ = StorageService.manager.storeImage(image, imageID: ref.key)
    }
    
    
    public func addImageToUser(url: String, userID: String) {
        addImage(url: url, ref: usersRef, id: userID)
    }
    
    
    
//    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
//        let userRef = usersRef.child(uID)
//
//        userRef.observeSingleEvent(of: .value) { (snapshot) in
//            guard let email = snapshot.childSnapshot(forPath: "email").value as? String else {return}
//            let currentAppUser = AppUser(email: email, uID: uID)
//            completion(currentAppUser)
//        }
//    }
}


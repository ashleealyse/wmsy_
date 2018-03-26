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
    public func addAppUser(_ appUser: AppUser) {
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
    
    
    public func addImageToUser(url: String, userID: String) {
        addImage(url: url, ref: usersRef, id: userID)
    }
    
    
    
    func getAppUser(with uID: String, completion: @escaping (_ user: AppUser) -> Void) {
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let name = snapshot.childSnapshot(forPath: "name").value as? String else {return}
            guard let photoID = snapshot.childSnapshot(forPath: "photoID").value as? String else {return}
            guard let age = snapshot.childSnapshot(forPath: "age").value as? String else {return}
            guard let userID = snapshot.childSnapshot(forPath: "userID").value as? String else {return}
            guard let bio = snapshot.childSnapshot(forPath: "bio").value as? String else {return}
            guard let badge = snapshot.childSnapshot(forPath: "badge").value as? Bool else {return}
            guard let flags = snapshot.childSnapshot(forPath: "flags").value as? Int else {return}
            
            
            let currentAppUser = AppUser(name: name, photoID: photoID, age: age, userID: userID, bio: bio, badge: badge, flags: flags)
            completion(currentAppUser)
        }
    }
    func getAppUsers(fromList userIDs: [String], completion: @escaping ([AppUser]) -> Void) {
        let userIdArray = userIDs
        let group = DispatchGroup()
        let userRef = DBService.manager.usersRef!
        
        var users = [AppUser]()
        for singleUser in userIdArray{
            group.enter()
            let ref = userRef.child(singleUser)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard
                    let userDict = snapshot.value as? [String: Any],
                    let name = userDict["name"] as? String ,
                    let photoID = userDict["photoID"] as? String,
                    let age = userDict["age"] as? String,
                    let userID = userDict["userID"] as? String,
                    let bio = userDict["bio"] as? String,
                    let badge = userDict["badge"] as? Bool,
                    let flags = userDict["flags"] as? Int
                    else {
                        group.leave()
                        return
                }
                let user = AppUser(name: name, photoID: photoID, age: age, userID: userID, bio: bio, badge: badge, flags: flags)
                users.append(user)
                group.leave()
            }) { (error) in
                print(error)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(users)
            print("loop finished")
        }
    }
}




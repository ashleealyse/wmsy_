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
    
    static var cachedUsers = [String: AppUser]()
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
        print("added new user \(appUser.name) with uid: \(appUser.userID)")
    }
    public func addImageToUser(url: String, userID: String) {
        addImage(url: url, ref: usersRef, id: userID)
    }
    public func checkIfUserExists(userID: String, completion: @escaping (Bool) -> Void) {
        usersRef.child(userID).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
        
    }
    
    
    func getAppUser(fromID uID: String, completion: @escaping (_ user: AppUser?) -> Void) {
        guard !uID.isEmpty else {
            print("got empty user id")
            completion(nil)
            return
        }
        if let user = DBService.cachedUsers[uID] {
            completion(user)
            return
        }
        
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard
                let userDict = snapshot.value as? [String: Any],
                var appUser = AppUser(fromDict: userDict)
            
            
            else {
                completion(nil)
                return
            }
            let group = DispatchGroup()
            
            
            
            if userDict["hostedWhims"] != nil {
                group.enter()
                print("getting hosted whims")
                self.getWhims(forUser: appUser, completion: { (whims) in
                    appUser.hostedWhims = whims
                    print("got hosted whims")
                    group.leave()
                })
            }
            if userDict["interests"] != nil {
                let interestDict = userDict["interests"] as? [String:Bool]
                var whimKeys = [String]()
                for interests in interestDict!{
                    whimKeys.append(interests.key)
                }
                group.enter()
                print("getting interests")
                self.getAllInterests(forUser: appUser, interestedWhimKeys: whimKeys, completion: { (interests) in
                    appUser.interests = interests
                    print("got interests")
                    group.leave()
                })
            }
            group.notify(queue: .main) {
                print("finished getting appUser")
                DBService.cachedUsers[uID] = appUser
                completion(appUser)
            }
        }
    }
    func getAppUsers(fromList userIDs: [String], completion: @escaping ([AppUser]) -> Void) {
        let userIdArray = userIDs
        let group = DispatchGroup()
        let userRef = DBService.manager.usersRef!
        
        var users = [AppUser]()
        for singleUser in userIdArray{
            group.enter()
            getAppUser(fromID: singleUser, completion: { (appUser) in
                if let appUser = appUser {
                    users.append(appUser)
                } else {
                    print("getAppUsers(fromID:\(singleUser)) error")
                }
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            completion(users)
        }
    }
    public func updateBio(_ bio: String, forUser user: AppUser) {
        let ref = usersRef.child(user.userID).child("bio")
        ref.setValue(bio)
        if let _ = DBService.cachedUsers[user.userID] {
            DBService.cachedUsers[user.userID]?.bio = bio
        }
        print("should have updated the bio")
    }
    
    
    static var cachedImageURLs = [String: String]()
    public func getUserImageURL(userID: String, completion: @escaping (String) -> Void) {
        if let url = DBService.cachedImageURLs[userID] {
            completion(url)
            return
        }
        
        let ref = usersRef.child(userID).child("photoID")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let url = snapshot.value as? String {
                DBService.cachedImageURLs[userID] = url
                completion(url)
            } else {
                print("no photo url")
                fatalError()
            }
        }
        
        
    }
    
    
}




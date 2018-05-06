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
    // Create a Whim by current user
    
    public func addWhimWith(category: Category,
                        title: String,
                        description: String,
                        hostImageURL: String,
                        location: String,
                        long: String,
                        lat: String,
                        duration: Int) {
        
//        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
//            print("Error: could not get current user id, please exit the app and log back in.")
//            return
//        }
        guard let currentUser = AppUser.currentAppUser else {
            print("Error: could not get current user id, please exit the app and log back in.")
            return
        }
        
        
        let ref = whimsRef.childByAutoId()
        
        let now = Date()
        let dateString = DateFormatter.wmsyDateFormatter.string(from: now)
        
        let expiration = now.addingTimeInterval(TimeInterval(duration * 3600))
        let expirationString = DateFormatter.wmsyDateFormatter.string(from: expiration)
        
        
        let whim = Whim(id: ref.key, category: category.rawValue, title: title, description: description, hostID: currentUser.userID, hostImageURL: currentUser.photoID, location: location, long: long, lat: lat, duration: duration, expiration: expirationString, finalized: false, timestamp: dateString, whimChats: [])
        AppUser.currentAppUser?.hostedWhims.append(whim)
        
        let group = DispatchGroup()
        group.enter()
        ref.setValue(["id": whim.id,
                      "category": whim.category.rawValue,
                      "title": whim.title,
                      "description": whim.description,
                      "hostID": whim.hostID,
                      "hostImageURL": whim.hostImageURL,
                      "location": whim.location,
                      "long": whim.long,
                      "lat": whim.lat,
                      "duration": whim.duration,
                      "expiration": whim.expiration,
                      "finalized": whim.finalized,
                      "timestamp": whim.timestamp,
                      "whimChat": whim.whimChats
        ]) { (error, _) in
            if let error = error {
                print("error saving Whim: \(error.localizedDescription)")
            } else {
                print("new Whim added to database!")
                group.leave()
            }
        }
        let userRef = usersRef.child(currentUser.userID).child("hostedWhims").child(whim.id)
        print(usersRef.child(currentUser.userID).key)
        group.enter()
        userRef.setValue(true)
        print("also added to users")
        group.leave()
    }
//    public func add(whim: Whim) {
//        let appUser = AppUser.singleUser // dummy
//        let ref = usersRef.child(appUser.userID)
//        ref.setValue([
//            "name" : appUser.name,
//            "photoID" : appUser.photoID,
//            "age" : appUser.age,
//            "userID" : appUser.userID,
//            "bio" : appUser.bio,
//            "badge" : appUser.badge,
//            "flags" : appUser.flags
//            ])
//    }
    public func getWhim(fromID whimID: String, completion: @escaping (Whim?) -> Void) {
        
        let whimRef = whimsRef.child(whimID)
        whimRef.observeSingleEvent(of: .value) { (snapshot) in
            guard
                let whimDict = snapshot.value as? [String: Any],
                var whim = Whim(fromDictionary: whimDict)
                else {
                    completion(nil)
                    return
            }
            if whimDict["messages"] != nil {
                self.getAllMessages(forWhim: whim, completion: { (messages) in
                    whim.whimChats = messages
                    completion(whim)
                })
            } else {
                completion(whim)
            } 
        }
    }
    public func getWhims(forUser user: AppUser, completion: @escaping ([Whim]) -> Void) {
        let userWhimsRef = usersRef.child(user.userID).child("hostedWhims")
        userWhimsRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let whimIDDict = snapshot.value as? [String: Bool] else {
                completion([])
                return
            }
            let whimIDs = whimIDDict.map{$0.key}
            self.getWhims(fromList: whimIDs, completion: { (whims) in
                completion(whims)
            })
        }
    }
    
    public func getWhims(fromList whimIDs: [String], completion: @escaping ([Whim]) -> Void) {
        let group = DispatchGroup()
        
        var whims = [Whim]()
        var count = 0
        print(whimIDs.count)
        for singleWhim in whimIDs {
            group.enter()
            print("getting whim with id: \(singleWhim)")
            getWhim(fromID: singleWhim, completion: { (whim) in
                if let whim = whim {
                    print("got single whim with id: \(singleWhim)")
                    whims.append(whim)
                    count += 1
                    print(count)
                }
                group.leave()
            })
        }
        group.notify(queue: .main) {
            print("getting whims from list finished")
            completion(whims)
            return
        }
    }
}

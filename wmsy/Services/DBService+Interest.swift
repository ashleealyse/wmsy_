//
//  DBService+Interest.swift
//  wmsy
//
//  Created by C4Q on 3/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    
    public func addInterest(forWhim whim: Whim) {
        let interestsRef = DBService.manager.interestsRef.child(whim.id).child(AuthUserService.manager.getCurrentUser()!.uid)
        interestsRef.setValue(false)
        let userRef = DBService.manager.usersRef.child(AuthUserService.manager.getCurrentUser()!.uid).child("interests").child(whim.id)
        userRef.setValue(false)
    }
    public func getAllInterests(forWhim whim: Whim,
                                completion: @escaping ([Interest]) -> Void) {
        let ref = DBService.manager.interestsRef.child(whim.id)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var interests = [Interest]()
            for child in snapshot.children {
                guard
                    let snapshot = child as? DataSnapshot,
                    let inChat = snapshot.value as? Bool
                    else {
                        print("error getting interest stuff")
                        return
                }
                let interest = Interest(whimID: whim.id, userID: snapshot.key, inChat: inChat)
                interests.append(interest)
            }
            completion(interests)
        }
        
    }
    
    
}

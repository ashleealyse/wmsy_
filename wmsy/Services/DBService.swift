//
//  DBService.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase


class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        whimsRef = rootRef.child("whims")
        super.init()
        
    }
    
    static let manager = DBService()
        
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var whimsRef: DatabaseReference!
    var messagesRef: DatabaseReference!
    
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("photoID").setValue(url)
        
    }
    
    
    // Create a Whim by current user
    
    public func addWhim(withCategory category: String, title: String, description: String, location: String, long: String, lat: String, duration: Int) {
        
        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
            print("Error: could not get current user id, please exit the app and log back in.")
            return
        }
        
        let ref = whimsRef.childByAutoId()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.timeStyle = .long
        formatter.dateStyle = .long
        let dateString = formatter.string(from: now)
        
        let expiration = now.addingTimeInterval(TimeInterval(duration * 3600))
        let expirationString = formatter.string(from: expiration)
        
        
        let whim = Whim(id: ref.key, category: category, title: title, description: description, hostID: currentUser.uid, location: location,long: long,lat: lat, duration: duration, expiration: expirationString, finalized: false, timestamp: dateString, whimChats: [])
        
        
        
        ref.setValue(["id": whim.id,
                      "category": whim.category,
                      "title": whim.title,
                      "description": whim.description,
                      "hostID": whim.hostID,
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
            }
        }
    }
}














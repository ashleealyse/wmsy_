//
//  DBService.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Foundation
import FirebaseDatabase


class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        super.init()
        
    }
    
    static let manager = DBService()
        
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
 
    
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("photoID").setValue(url)
        
    }
    
    
}

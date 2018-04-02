//
//  AppUser.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct AppUser: Codable {
    let name: String
    let photoID: String
    let age: String
    let userID: String
    var bio: String
    let badge: Bool
    let flags: Int
    var hostedWhims: [Whim]
    var interests: [Interest]
    
    
    init(name: String, photoID: String, age: String, userID: String, bio: String, badge: Bool, flags: Int, hostedWhims: [Whim], interests: [Interest]) {
        self.name = name
        self.photoID = photoID
        self.age = age
        self.userID = userID
        self.bio = bio
        self.badge = badge
        self.flags = flags
        self.hostedWhims = hostedWhims
        self.interests = interests
    }
    
    init?(fromDict userDict: [String: Any]) {
        guard
            let name = userDict["name"] as? String,
            let photoID = userDict["photoID"] as? String,
            let age = userDict["age"] as? String,
            let userID = userDict["userID"] as? String,
            let bio = userDict["bio"] as? String,
            let badge = userDict["badge"] as? Bool,
            let flags = userDict["flags"] as? Int
            else {
                return nil
        }
        self.name = name
        self.photoID = photoID
        self.age = age
        self.userID = userID
        self.bio = bio
        self.badge = badge
        self.flags = flags
        self.hostedWhims = []
        self.interests = []
    }
    
    static let singleUser = AppUser(name: "Ashlee", photoID: "q1w2e3r4t5y6", age: "24" , userID: "Q1W2E3R4T5Y6", bio: "I LOVE KRAV MAGA, TRYING NEW FOODS, ANIMAL WELFARE, AND LONG WALKS ON THE BEACH. I'M ALWAYS DOWN FOR THRIFT SHOPPING AND COLLECTING VINTAGES.", badge: true, flags: 420, hostedWhims: [Whim](), interests: [Interest]())
//    static var currentAppUser: AppUser?
    
    
}

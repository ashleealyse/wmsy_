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
    let bio: String
    let badge: Bool
    let flags: Int
    
    static let singleUser = AppUser(name: "Ashlee", photoID: "q1w2e3r4t5y6", age: "24" , userID: "Q1W2E3R4T5Y6", bio: "I LOVE KRAV MAGA, TRYING NEW FOODS, ANIMAL WELFARE, AND LONG WALKS ON THE BEACH. I'M ALWAYS DOWN FOR THRIFT SHOPPING AND COLLECTING VINTAGES.", badge: true, flags: 420)
}

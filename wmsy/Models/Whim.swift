//
//  Whim.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

extension DateFormatter {
//    "March 21, 2018 at 3:11:50 PM EDT"
    static let wmsyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.timeStyle = .long
        formatter.dateStyle = .long
        return formatter
    }()
}


struct Whim: Codable {
    let id: String
    let category: String
    let title: String
    let description: String
    let hostID: String
    let location: String
    let long: String
    let lat: String
    let duration: Int
    let expiration: String
    let finalized: Bool
    let timestamp: String
    var whimChats: [Message]
    
//    static let firstWhim = Whim(id: "nbjaeksd345", category: "Arts", title: "First Whim", description: "Join me on my first whim", hostID: "gaefnsdk345", location: "2 Rivington Street, New York, NY", duration: 56788765, finalized: false, timestamp: "456789965")
    
//    static let firstWhim = Whim(id: "ghjkg", category: "Arts", title: "my first whime", description: "do stuff, good stuff", hostID: "huibjdw", approxLocation: "near the park", location: "southwest corner of the park", duration: 3, expiration: "45678", finalized: false, timestamp: "456789", whimChats: [])
    
    
    
//<<<<<<< HEAD
//    init(id: String,
//         category: String,
//         title: String,
//         description: String,
//         hostID: String,
//         approxLocation: String,
//         location: String,
//         duration: Int,
//         expiration: String?,
//         finalized: Bool?,
//         timestamp: String = "\(Date().timeIntervalSince1970)",
//         whimChats: [Message] = []) {
//        let now = Date()
//        let oneDayFromNow = Calendar.current.date(byAdding: .day, value: 1, to: now)
//=======
    init(id: String, category: String, title: String, description: String, hostID: String, location: String, long: String, lat: String, duration: Int, expiration: String, finalized: Bool, timestamp: String, whimChats: [Message]) {
//>>>>>>> qa
        self.id = id
        self.category =  category
        self.title =  title
        self.description =  description
        self.hostID =  hostID
        self.location =  location
        self.long = long
        self.lat = lat
        self.duration =  duration
        self.expiration = expiration
//        self.expiration = expiration ?? "\(oneDayFromNow?.timeIntervalSince1970)"
        self.finalized =  finalized ?? false
        self.timestamp =  timestamp
        self.whimChats =  whimChats
        let today = Date.init()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
    }
    
    
//    // convenience init
//    init(id: String, category: String, title: String, description: String, hostID: String, approxLocation: String, location: String, duration: Int) {
//        self.init(id: id, category: category, title: title, description: description, hostID: hostID, approxLocation: approxLocation, location: location, duration: duration, expiration:  "expiration", finalized: false, timestamp: "\(Date().timeIntervalSince1970)", whimChats: [])
//        print("\(Date().timeIntervalSince1970)")
//    }
    
}


extension Array where Element == Whim {
    func sortedByTimestamp() -> [Whim] {
        return self.sorted {$0.timestamp > $1.timestamp}
    }
    
}

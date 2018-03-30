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
    let hostImageURL: String
    let location: String
    let long: String
    let lat: String
    let duration: Int
    let expiration: String
    let finalized: Bool
    let timestamp: String
    var whimChats: [Message]
    
    init(id: String, category: String, title: String, description: String, hostID: String, hostImageURL: String, location: String, long: String, lat: String, duration: Int, expiration: String, finalized: Bool, timestamp: String, whimChats: [Message]) {
        self.id = id
        self.category =  category
        self.title =  title
        self.description =  description
        self.hostID =  hostID
        self.hostImageURL = hostImageURL
        self.location =  location
        self.long = long
        self.lat = lat
        self.duration =  duration
        self.expiration = expiration
        self.finalized =  finalized
        self.timestamp =  timestamp
        self.whimChats =  whimChats
        let today = Date.init()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
    }
    
    init?(fromDictionary whimDict: [String: Any]) {
        guard
            let id = whimDict["id"] as? String,
            let category = whimDict["category"] as? String,
            let title = whimDict["title"] as? String,
            let description = whimDict["description"] as? String,
            let hostID = whimDict["hostID"] as? String,
            let hostImageURL = whimDict["hostImageURL"] as? String,
            let location = whimDict["location"] as? String,
            let long = whimDict["long"] as? String,
            let lat = whimDict["lat"] as? String,
            let duration = whimDict["duration"] as? Int,
            let expiration = whimDict["expiration"] as? String,
            let finalized = whimDict["finalized"] as? Bool,
            let timestamp = whimDict["timestamp"] as? String
            else {
                return nil
        }
        self.id = id
        self.category =  category
        self.title =  title
        self.description =  description
        self.hostID =  hostID
        self.hostImageURL = hostImageURL
        self.location =  location
        self.long = long
        self.lat = lat
        self.duration =  duration
        self.expiration = expiration
        self.finalized =  finalized
        self.timestamp =  timestamp // TODO: turn this into a TimeInterval for app?
        self.whimChats =  []
    }
    
}

extension Array where Element == Whim {
    func sortedByTimestamp() -> [Whim] {
        return self.sorted(by: { (first, second) -> Bool in
            let firstTimeStamp = DateFormatter.wmsyDateFormatter.date(from: first.timestamp)!.timeIntervalSinceNow
            let secondTimeStamp = DateFormatter.wmsyDateFormatter.date(from: second.timestamp)!.timeIntervalSinceNow
            return firstTimeStamp > secondTimeStamp
        })
    }
}


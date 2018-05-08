//
//  DBService+Get.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase
import GoogleMaps

extension DBService {
    
    // GET ALL WHIMS
    public func getAllWhims(completion: @escaping (_ whims: [Whim]) -> Void) {
        whimsRef.observe(.value) { (dataSnapshot) in
            var whims: [Whim] = []
            
            guard let whimSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for whimSnapshot in whimSnapshots {
                guard let whimDict = whimSnapshot.value as? [String: Any] else { return }
                guard
                let id = whimDict["id"] as? String,
                let category = (whimDict["category"] as? String)?.lowercased(),
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
                        print("Couldn't get post")
                        return
                }
                let whimChats = [Message]()
                let whim = Whim(id: id, category: category, title: title, description: description, hostID: hostID, hostImageURL: hostImageURL, location: location, long: long, lat: lat, duration: duration, expiration: expiration, finalized: finalized, timestamp: timestamp, whimChats: whimChats)
                whims.append(whim)
            }
            completion(whims)
        }
    
        //            let feed = FeedMapVC()
        //            var finalWhims = whims.filter({ (whim) -> Bool in
        //                let expiration = feed.getTimeRemaining(whim: whim)
        //                if expiration.contains("-"){
        //                    return false
        //                }
        //                return true
        //            })
    }
    
    
    // GET SUBSET OF WHIMS BASED ON CATEGORY
    public func getCategoryWhims(fromCategory category: String, location: CLLocation, completion: @escaping ([Whim]) -> Void) {
        getAllWhims { (whims) in
            let userLocation = location
            var whimArr = [Whim]()
            let categoryWhims = whims.filter{$0.category.rawValue == category}
            for whim in categoryWhims{
                let long = Double(whim.long)
                let lat = Double(whim.lat)
                let whimLocation = CLLocation(latitude: lat!, longitude: long!)
                let distanceInMeters = whimLocation.distance(from: userLocation)
                if distanceInMeters <= 1609{
                    whimArr.append(whim)
                }
            }
            completion(whimArr)
        }
    }
    
    
    public func getClosestWhims(location: CLLocation,completion: @escaping ([Whim]) -> Void){
        getAllWhims { (whims) in 
            let userLocation = location
            var whimArr = [Whim]()
            for whim in whims{
                let long = Double(whim.long)
                let lat = Double(whim.lat)
                let whimLocation = CLLocation(latitude: lat!, longitude: long!)
                let distanceInMeters = whimLocation.distance(from: userLocation)
                if distanceInMeters <= 1609{
                    whimArr.append(whim)
                }
            }
            completion(whimArr.sortedByTimestamp())
        }
    }
}

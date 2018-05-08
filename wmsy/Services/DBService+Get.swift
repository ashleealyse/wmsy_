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
                guard let whim = Whim.init(fromDictionary: whimDict) else {
                    print("couldn't get post")
                    return
                }
                whims.append(whim)
            }
            completion(whims)
        }
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

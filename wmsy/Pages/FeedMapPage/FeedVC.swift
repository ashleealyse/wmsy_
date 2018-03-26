//
//  FeedVC.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

class FeedVC: UIViewController {

    var feedView = FeedView()
    
    var locationManager = CLLocationManager()
    
    var feedWhims: [Whim] = [] {
        didSet {
            print("FeedVC feedWhims: \(feedWhims)")
        }
    }
    
    var expandedRows = Set<Int>()
    
    weak var delegate: ParentDelegate?

    // sends map updates to the parent vc - FeedMapVC
    var userLocation = CLLocation(){
        didSet{
            print("MapVC userLocation set")
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims
                self.delegate?.updateChildren(whims: whims)
            }
        }
    }
    
    // takes in Whims, updates local whim array
    public func update(withWhims: [Whim]) {
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        
//        feedWhims = feedWhims.sortedByTimestamp()
        
        view.addSubview(feedView)
        view.backgroundColor = .green
//        feedView.tableView.register(FeedCell.self, forCellReuseIdentifier: "WhimFeedCell")
       
//        feedView.tableView.rowHeight = UITableViewAutomaticDimension
//        feedView.tableView.estimatedRowHeight = 90
//        feedView.tableView.separatorStyle = .none
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        
        
    }
}

extension FeedVC: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        self.userLocation = location
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}


//
//extension FeedVC: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
//            return
//        }
//
////        switch cell.isExpanded {
////        case true:
////            self.expandedRows.remove(indexPath.row)
////        default:
////            self.expandedRows.insert(indexPath.row)
////        }
////
//        cell.isExpanded = !cell.isExpanded
//
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//}
//
//extension FeedVC: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return feedWhims.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
//
//        cell.isExpanded = self.expandedRows.contains(indexPath.row)
//        let whim = feedWhims[indexPath.row]
//        cell.collapsedView.postTitleLabel.text = whim.title
//        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
//        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
//            cell.collapsedView.userImageButton.setImage(image, for: .normal)
//        })
//        cell.expandedView.postDescriptionTF.text = whim.description
//        return cell
//
//    }
//}


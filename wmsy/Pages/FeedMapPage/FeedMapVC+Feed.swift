//
//  FeedMapVC+Feed.swift
//  wmsy
//
//  Created by C4Q on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

extension FeedMapVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
            return
        }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        default:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension FeedMapVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedWhims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
        
//        cell.collapsedView.delegate = self
//        cell.expandedView.delegate = self
        cell.delegate = self
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.whim = whim
        cell.collapsedView.postTitleLabel.text = whim.title
        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            cell.collapsedView.userImageButton.setImage(image, for: .normal)
        })
        cell.expandedView.postDescriptionTF.text = whim.description
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){
            cell.expandedView.interestedButton.setImage(#imageLiteral(resourceName: "interestedCircleIcon"), for: .normal)
        }else{
            cell.expandedView.interestedButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
        }
            
     

        return cell
    }
    
    public func getInterestKeys(appUser: AppUser) -> [String]{
        var interests = appUser.interests
        var finalArr = [String]()
        for interest in interests{
            finalArr.append(interest.whimID)
        }
        return finalArr
    }
    
    
    
}


//extension FeedMapVC: CollapsedFeedCellViewDelegate {
//
//    func userProfileButtonPressed() {
//        guestProfile.modalPresentationStyle = .overCurrentContext
//        guestProfile.modalTransitionStyle = .crossDissolve
//        present(guestProfile, animated: true, completion: nil)
//    }
//
//}

extension FeedMapVC: FeedCellViewDelegate {
    
    func showOnMapButtonPressed(whim: Whim) {
        verticalPinConstraint?.deactivate()
        
        if mapUp {
            pinFilterViewToBottom()
        } else {
            pinFilterViewToTop()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.mapUp = !self.mapUp
        })
        let location = CLLocation.init(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
        self.mapView.mapView.animate(to: camera)
        self.mapView.detailView.whimTitle.text = whim.title
        self.mapView.detailView.whimDescription.text = whim.description
        let hostURL = URL(string: whim.hostImageURL)
        let hostID = whim.hostID
        DBService.manager.getAppUser(fromID: hostID) { (appUser) in
            self.currentUser = appUser
        }
        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal)
        
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){
            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "interestedCircleIcon"), for: .normal)
        }else{
            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
        }
        self.mapView.detailView.isHidden = false
        
        print("Show on Map Button Pressed")
        
    }
    
    func interestButtonClicked(whim: Whim) {
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){
            //User is interested
            print("Current User: \(currentUser?.name ?? "No current user") Is NOT Interested in Whim #: \(whim.id) by Host: \(whim.hostID)")
            DBService.manager.removeInterest(forWhim: whim)
            self.feedView.tableView.reloadData()
        } else {
            //User is not interested
            print("Current User: \(currentUser?.name ?? "No current user") is Interested in Whim #: \(whim.id) by Host: \(whim.hostID)")
            DBService.manager.addInterest(forWhim: whim)
            self.feedView.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    func userProfileButtonPressed(whim: Whim) {
        print("Show Whim Host User Profile")
        guestProfile.modalPresentationStyle = .overCurrentContext
        guestProfile.modalTransitionStyle = .crossDissolve
        let url = URL(string: whim.hostImageURL)
        
        DBService.manager.getAppUser(fromID: whim.hostID) { (appUser) in
            if let appUser = appUser {
                self.guestProfile.configure(with: appUser)
                self.present(self.guestProfile, animated: true, completion: nil)
            }
        }
    }
}


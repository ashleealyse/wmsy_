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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedWhims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
   
        cell.delegate = self
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.whim = whim
        let time = getTimeRemaining(whim: whim)
        let titleCount = whim.title.count
        
        let customString = NSMutableAttributedString.init(string: "\(whim.title) \(time)", attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 16.0)!])
        customString.addAttributes([NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 14.0)!,NSAttributedStringKey.foregroundColor:UIColor.lightGray], range: NSRange(location:titleCount,length: time.count + 1))

        
        cell.collapsedView.postTitleLabel.attributedText = customString
        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            cell.collapsedView.userImageButton.setImage(image, for: .normal)
        })
        
        cell.expandedView.postDescriptionTF.text = whim.description
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){
            cell.expandedView.interestedButton.titleLabel?.textColor = .white
            cell.expandedView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            cell.expandedView.interestedButton.setTitle("Remove Interest", for: .normal)
        }else{
            cell.expandedView.interestedButton.titleLabel?.textColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            cell.expandedView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.3)
            cell.expandedView.interestedButton.setTitle("Show Interest", for: .normal)
        }
        
        if whim.hostID == AppUser.currentAppUser?.userID{
            cell.expandedView.interestedButton.isHidden = true
            cell.expandedView.showOnMapButton.isHidden = true
            return cell
        }
        cell.expandedView.interestedButton.isHidden = false
        cell.expandedView.showOnMapButton.isHidden = false

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
    
    
    public func getTimeRemaining(whim: Whim) -> String{
        let expirationDate = DateFormatter.wmsyDateFormatter.date(from: whim.expiration)
        let currentDate = Date()
        let hoursRemaining =  expirationDate!.hours(from: currentDate)
        let minutesRemaining = expirationDate!.minutes(from: currentDate)
        let hourConversion = hoursRemaining * 60
        let finalMinutes = minutesRemaining - hourConversion
        
        switch hoursRemaining{
        case 0:
            return "\(finalMinutes.description) m left"
        default:
            return "\(hoursRemaining.description) hr left"
        }
    }
    
    
}

extension FeedMapVC: FeedCellViewDelegate {
    
    func showOnMapButtonPressed(whim: Whim) {
        self.currentWhim = whim
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
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.0)
        self.mapView.mapView.animate(to: camera)
        let expiration = getTimeRemaining(whim: whim)
        let titleCount = whim.title.count
        let customString = NSMutableAttributedString.init(string: "\(whim.title) \(expiration)", attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 18.0)!])
        customString.addAttributes([NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 14.0)!,NSAttributedStringKey.foregroundColor:UIColor.lightGray], range: NSRange(location:titleCount,length: expiration.count + 1))
        self.mapView.detailView.whimTitle.attributedText = customString
        self.mapView.detailView.whimDescription.text = whim.description
        let hostURL = URL(string: whim.hostImageURL)
        let hostID = whim.hostID
        DBService.manager.getAppUser(fromID: hostID) { (appUser) in
            self.currentUser = appUser
        }
        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal)
        
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){

            self.mapView.detailView.interestedButton.titleLabel?.textColor = .white
            self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)            
            self.mapView.detailView.interestedButton.setTitle("Remove Interest", for: .normal)

        }else{
            self.mapView.detailView.interestedButton.titleLabel?.textColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.3)
            self.mapView.detailView.interestedButton.setTitle("Show Interest", for: .normal)

        }
        self.feedView.tableView.reloadData()
        self.mapView.detailView.isHidden = false        
    }
    
    func interestButtonClicked(whim: Whim) {
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whim.id){
            //User is no longer interested
            print("Current User: \(currentUser?.name ?? "No current user") Is NOT Interested in Whim #: \(whim.id) by Host: \(whim.hostID)")
            DBService.manager.removeInterest(forWhim: whim, forUser: AppUser.currentAppUser!)
            
//            self.feedView.tableView.reloadData()
        } else {
            //User is now interested
            print("Current User: \(currentUser?.name ?? "No current user") is Interested in Whim #: \(whim.id) by Host: \(whim.hostID)")
            DBService.manager.addInterest(forWhim: whim)
//            self.feedView.tableView.reloadData()
        }
        self.feedView.tableView.reloadData()
        
        
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


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
        cell.collapsedView.delegate = self
        cell.expandedView.delegate = self
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.collapsedView.postTitleLabel.text = whim.title
        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            cell.collapsedView.userImageButton.setImage(image, for: .normal)
        })
        cell.expandedView.postDescriptionTF.text = whim.description
        return cell
        
    }
}


extension FeedMapVC: CollapsedFeedCellViewDelegate {
    
    func userProfileButtonPressed() {
        guestProfile.modalPresentationStyle = .overCurrentContext
        guestProfile.modalTransitionStyle = .crossDissolve
        present(guestProfile, animated: true, completion: nil)
    }
    
}

extension FeedMapVC: ExpandedFeedCellViewDelegate {
    
    func showOnMapButtonPressed() {
        //Show Map
        print("MAP")
    }
    
    func interestButtonClicked() {
        interestButtonCounter += 1
        if interestButtonCounter % 2 == 0 {
            //User is interested
            print("User Is Not Interested")
        } else {
            //User is not interested
            print("User Is Interested")
        }
    }
    
    
}


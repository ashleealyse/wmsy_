//
//  FeedMapVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

protocol ParentDelegate: class {
    func updateChildren(whims: [Whim]) -> Void
}

class FeedMapVC: MenuedViewController {
    
    var feedVC = FeedVC()
    var mapVC = MapVC()
    var filtersVC = FiltersVC()
    
    var feedWhims: [Whim] = [] {
        didSet {
            feedWhims = feedWhims.sortedByTimestamp()
            feedVC.feedView.tableView.reloadData()
            mapVC.mapView.mapView.clear()
            for whim in feedWhims{
                let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
                let marker = GMSMarker(position: position)
                marker.title = whim.title
                marker.snippet = whim.description
                marker.map = mapVC.mapView.mapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()

        mapVC.delegate = self
        feedVC.delegate = self
        view.addSubview(feedVC.feedView)
        
        feedVC.feedView.snp.makeConstraints { (make) in

            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(mapVC.mapView)
        mapVC.mapView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
        }
        
        view.addSubview(filtersVC.filtersView)
        
        
        
        configureNavBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        feedVC.feedView.tableView.reloadData()
    }
    
    // setup UIBarButtonItem
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem

        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "wmsyCategoryIcon"), style: .plain, target: self, action: #selector(hostAChat))
        navigationItem.rightBarButtonItem = topRightBarItem
    }
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    
    @objc func hostAChat() {
        navigationController?.pushViewController(ChatRoomVC(), animated: true)
        print("temporary testing link for WhimChat")
    }
}




extension FeedMapVC: ParentDelegate {
    func updateChildren(whims: [Whim]) {
        self.feedWhims = whims
    }
}

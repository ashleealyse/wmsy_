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


class FeedMapVC: MenuedViewController {
    
    let toolBarHeight: CGFloat = 90.0
    var verticalPinConstraint: Constraint? = nil
    var feedView = FeedView()
    var mapView = MapView()
    var filtersView = FiltersView()
    var filterMapContainerView = UIView()
    var mapUp: Bool = false
    
    var guestProfile = GuestProfileVC()
    var hostProfileView = GuestProfileVC()

    var expandedRows = Set<Int>()
    var interestButtonCounter = 0
    var currentWhim: Whim?
    
    var currentUser = AppUser.currentAppUser
    
    var currentUsersInterests = Set<String>() {
        didSet {
            print("Current User Interests: \(currentUsersInterests.count)")
        }
    }
    
    var locationManager = CLLocationManager()
    let categoryList = categoryTuples
    var userLocation = CLLocation(){
        didSet{
            print("userLocation set")
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims.filter(){$0.finalized != true}
            }
        }
    }
    
    var feedWhims: [Whim] = [] {
        didSet {
            print("number of whims to load: \(feedWhims.count)")
            feedWhims = feedWhims.sortedByTimestamp()
            feedView.tableView.reloadData()
            mapView.mapView.clear()
            for whim in feedWhims{
                let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
                let marker = GMSMarker(position: position)
                let timeRemaining = getTimeRemaining(whim: whim)
                marker.userData = ["title": whim.title,
                                   "description": whim.description,
                                   "hostImageURL": whim.hostImageURL,
                                   "category": whim.category,
                                   "hostID" : whim.hostID,
                                   "whimID": whim.id,
                                   "expiration": timeRemaining
                ]
                marker.icon = GMSMarker.markerImage(with: Stylesheet.Colors.WMSYDeepViolet)
                marker.map = mapView.mapView
            }
        }
    }
    
    
    @objc func refreshData(refreshControl: UIRefreshControl){
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims.filter(){$0.finalized != true}
            self.feedView.tableView.reloadData()
            refreshControl.blink()
            refreshControl.endRefreshing()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: Stylesheet.Colors.WMSYDeepViolet)
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString.init(string: "loading whims")
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = Stylesheet.Colors.WMSYNeonPurple.withAlphaComponent(0.5)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.feedView.tableView.refreshControl = refreshControl
        currentUser = AppUser.currentAppUser
        if let currentUser = currentUser {
            print("current user: \(currentUser.name)")
            currentUsersInterests = Set(currentUser.interests.map{$0.whimID})
        }
        
        SVProgressHUD.dismiss()

        configureNavBar()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        layoutFeedMapView()
        layoutfilterMapContainer()
        layoutFiltersView()
        layoutMapView()
        addPanGesture(view: filterMapContainerView)
        addTapGesture(view: feedView)
        self.mapView.detailView.isHidden = true
        self.mapView.mapView.delegate = self
        self.mapView.detailView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MenuNotificationTracker.manager.delegate = MenuData.manager
    }
    

    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FeedMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    func addTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FeedMapVC.openFeed(sender:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tap)
    }
    
    @objc func openFeed(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended, .began, .changed:
            print("ended")
            toggleMap(sender: sender)
        default:
            break
        }
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let filterMapContainerView = sender.view!
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        switch sender.state {
        case .began, .changed:
            //Check to make sure new center is within bounds
            filterMapContainerView.center = CGPoint(x: view.center.x, y: filterMapContainerView.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if filterMapContainerView.frame.minY > feedView.frame.maxY {
                print(filterMapContainerView.frame.minY)
                print(feedView.frame.minY)
                verticalPinConstraint?.deactivate()
                self.mapUp = false
                self.pinFilterViewToBottom()
                UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                })
            }
            if filterMapContainerView.frame.minY <= CGFloat(368) || velocity.y < -300 {
                verticalPinConstraint?.deactivate()
                self.mapUp = !self.mapUp
                self.pinFilterViewToTop()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            if velocity.y > 300 {
                verticalPinConstraint?.deactivate()
                self.pinFilterViewToBottom()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
           
        default:
            break
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("removing live feed updates")
//        DBService.manager.whimsRef.removeAllObservers()
    }
    
    
    func layoutFeedMapView() {
        view.addSubview(feedView)

        feedView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(toolBarHeight)
        }
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
    }
    func layoutfilterMapContainer() {
        view.addSubview(filterMapContainerView)
        filterMapContainerView.snp.makeConstraints { (make) in
//            make.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            verticalPinConstraint = make.top.equalTo(feedView.snp.bottom).constraint
        }
    }
    func layoutFiltersView() {
        filterMapContainerView.addSubview(filtersView)
        filtersView.snp.makeConstraints { (make) in
            make.height.equalTo(toolBarHeight)
            make.leading.equalTo(filterMapContainerView.snp.leading)
            make.trailing.equalTo(filterMapContainerView.snp.trailing)
            make.top.equalTo(filterMapContainerView.snp.top)
        }
        filtersView.categoriesCV.delegate = self
        filtersView.categoriesCV.dataSource = self
        filtersView.categoriesCV.reloadData()
        filtersView.clearSearchButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)

    }
    
    func layoutMapView() {
        filterMapContainerView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(filtersView.snp.bottom)
            make.leading.equalTo(filterMapContainerView.snp.leading)
            make.trailing.equalTo(filterMapContainerView.snp.trailing)
            make.height.equalTo(feedView)
            make.bottom.equalTo(filterMapContainerView.snp.bottom)
        }

        let mylocation = mapView.mapView.myLocation
        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
                                                          longitude: (mylocation?.coordinate.longitude)!,
                                                          zoom: mapView.zoomLevel)
        mapView.mapView.settings.myLocationButton = true
        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
    
    
    
    // setup UIBarButtonItems
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feedIcon"), style: .plain, target: self, action: #selector(showMenu(sender:)))
        topLeftBarItem.tintColor = Stylesheet.Colors.WMSYKSUPurple
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        topRightBarItem.tintColor = Stylesheet.Colors.WMSYKSUPurple
        navigationItem.rightBarButtonItem = topRightBarItem
        
        
    }
    
    @objc func showMenu(sender: UIViewController){
        openMenu(sender: sender)
    }
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: false)
        
        navigationController?.isToolbarHidden = true
        print("Show Whim Host User Profile")
//        CreateWhimTVC().modalPresentationStyle = .none
//        self.present(CreateWhimTVC(), animated: false, completion: nil)
    }
    
    func pinFilterViewToBottom() {
        filterMapContainerView.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(feedView.snp.bottom).constraint
        }
    }
    
    func pinFilterViewToTop() {
        filterMapContainerView.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint
        }
    }
    
    @objc func toggleMap(sender: UITapGestureRecognizer) {
        verticalPinConstraint?.deactivate()
        
        if mapUp {
            pinFilterViewToBottom()
            self.mapView.detailView.isHidden = true
        } else {
            pinFilterViewToTop()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.mapUp = !self.mapUp
        })
    }
    
    @objc func clearSearch() {
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims
            self.filtersView.categoriesCV.deselectAllItems(animated: false)
            
        }
        self.expandedRows = Set<Int>()
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}


extension UICollectionView {
    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
}

extension UIView{
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}

extension Date{
func hours(from date: Date) -> Int {
    return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
}

func minutes(from date: Date) -> Int {
    return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
}
}

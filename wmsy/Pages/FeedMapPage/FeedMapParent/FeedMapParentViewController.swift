//
//  FeedMapParentViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import SVProgressHUD

class FeedMapParentViewController: MenuedViewController {
    
    let navBarVC = NavBarViewController()
    let feedVC = FeedViewController()
    let toolbarVC = ToolbarViewController()
    let mapVC = MapViewController()
    let iphoneXBottomBarView = UIView()
    
    
    let toolbarHeight: CGFloat = 120.0
    
    var selectedCategories = Set<Category>()
    var currentLocation: CLLocation?
    var selectedDistance: Int = 25
    var allWhims = [Whim]() {
        didSet {
            feedVC.updateWhimsTo(displayingWhims)
            mapVC.updateWhimsTo(displayingWhims)
        }
    }
    var displayingWhims: [Whim] {
        return allWhims
            .filter{ (selectedCategories.contains($0.category) || selectedCategories.isEmpty)
                    && $0.withinDistance(currentLocation, distance: 25)
        }
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.WMSYImperial
        self.navigationController?.navigationBar.isHidden = true
        SVProgressHUD.dismiss()
        
        self.add(navBarVC)
        self.add(feedVC)
        self.add(toolbarVC)
        self.add(mapVC)
        
        self.layoutNavBarVC()
        self.layoutFeedVC()
        self.layoutToolbarVC()
        self.layoutMapVC()
        self.layoutIphoneXBottomBarView()
        
        feedVC.delegate = self
        toolbarVC.delegate = self
        mapVC.delegate = self
        
        addPanToolbarGesture()
        addTapNavBarToToggleFeedGesture()
        
        navBarVC.navView.leftButton.addTarget(self, action: #selector(showMenu(sender:)), for: .touchUpInside)
        navBarVC.navView.rightButton.addTarget(self, action: #selector(hostAWhim), for: .touchUpInside)
        
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Constraints
    private func layoutNavBarVC() {
        navBarVC.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height)
        }
    }
    private func layoutFeedVC() {
        feedVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(navBarVC.view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(toolbarHeight)
        }
    }
    private func layoutToolbarVC() {
        toolbarVC.view.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(toolbarHeight)
            verticalPinConstraint = make.top.equalTo(feedVC.view.snp.bottom).constraint
        }
    }
    private func layoutMapVC() {
        mapVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(toolbarVC.view.snp.bottom)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(feedVC.view).offset(1)
        }
    }
    private func layoutIphoneXBottomBarView() {
        self.view.addSubview(iphoneXBottomBarView)
        iphoneXBottomBarView.backgroundColor = Stylesheet.Colors.WMSYImperial
        iphoneXBottomBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    // MARK: - Feed-to-Map animations
    var mapIsShowing: Bool = false
    var verticalPinConstraint: Constraint?
    private func addPanToolbarGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        toolbarVC.view.addGestureRecognizer(pan)
    }
    private func addTapNavBarToToggleFeedGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleMap(sender:)))
        self.navBarVC.view.addGestureRecognizer(tap)
    }
    
    private func pinToolbarToBottom() {
        verticalPinConstraint?.deactivate()
        toolbarVC.view.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(feedVC.view.snp.bottom).constraint
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.toolbarVC.view.frame.origin.y = self.feedVC.view.frame.maxY
            self.mapVC.view.frame.origin.y = self.toolbarVC.view.frame.maxY
            self.view.layoutIfNeeded()
        })
        self.mapIsShowing = true
    }
    private func pinToolbarToTop() {
        verticalPinConstraint?.deactivate()
        toolbarVC.view.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(navBarVC.view.snp.bottom).offset(-1).constraint
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.toolbarVC.view.frame.origin.y = self.navBarVC.view.frame.maxY - 1
            self.mapVC.view.frame.origin.y = self.toolbarVC.view.frame.maxY
            self.view.layoutIfNeeded()
        })
        self.mapIsShowing = false
    }
    @objc func toggleMap(sender: UITapGestureRecognizer) {
        verticalPinConstraint?.deactivate()
        if mapIsShowing {
            pinToolbarToBottom()
//            self.mapView.detailView.isHidden = true
        } else {
            pinToolbarToTop()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.mapIsShowing = !self.mapIsShowing
        })
    }
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        guard let toolbar = sender.view else { return }
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        switch sender.state {
        case .began, .changed:
            //Check to make sure new center is within bounds
            toolbar.center = CGPoint(x: view.center.x, y: toolbar.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            correctToolbarFrame()
        case .ended:
            if toolbar.frame.minY <= feedVC.view.frame.maxY / 2 || velocity.y <= -300 {
                self.pinToolbarToTop()
            }
            if toolbar.frame.minY > feedVC.view.frame.maxY / 2 || velocity.y >= 300 {
                self.pinToolbarToBottom()
            }
        default: break
        }
    }
    private func correctToolbarFrame() {
        // correct toolbar if dragged too high
        if toolbarVC.view.frame.origin.y < navBarVC.view.frame.maxY {
            toolbarVC.view.frame.origin.y = navBarVC.view.frame.maxY - 1
        }
        // correct toolbar if dragged too low
        if toolbarVC.view.frame.origin.y > feedVC.view.frame.maxY {
            toolbarVC.view.frame.origin.y = feedVC.view.frame.maxY
        }
        mapVC.view.frame.origin.y = toolbarVC.view.frame.maxY
    }
    
    // MARK: - Database networking
    public func loadData() {
        DBService.manager.getAllWhims { [weak self] (whims) in
            self?.allWhims = whims
        }
    }
    
    // MARK: - Helper Functions
    @objc func showMenu(sender: UIViewController){
        navBarVC.navView.leftButton.imageView?.tintColor = Stylesheet.Colors.WMSYKSUPurple
        openMenu(sender: sender)
    }
    @objc func hostAWhim() {
        let vc = CreateWhimTVC()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false) ?? present(vc, animated: false, completion: nil)
        print("Show Whim Host User Profile")
    }
    
}



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

class FeedMapParentViewController: MenuedViewController {
    
    let navBarVC = NavBarViewController()
    let feedVC = FeedViewController()
    let toolbarVC = ToolbarViewController()
    let mapVC = MapViewController()
    
    let toolbarHeight: CGFloat = 90.0
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add(navBarVC)
        self.add(feedVC)
        self.add(toolbarVC)
        self.add(mapVC)
        
        self.layoutNavBarVC()
        self.layoutFeedVC()
        self.layoutToolbarVC()
        self.layoutMapVC()
        
        feedVC.delegate = self
        toolbarVC.delegate = self
        mapVC.delegate = self
        
        addPanToolbarGesture()
        addTapNavBarToToggleFeedGesture()
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
    
    // MARK: - UI helper Functions
    private func layoutNavBarVC() {
        navBarVC.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.height.equalTo(64)
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
        toolbarVC.view.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(feedVC.view.snp.bottom).constraint
        }
    }
    private func pinToolbarToTop() {
        toolbarVC.view.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(navBarVC.view.snp.bottom).offset(-1).constraint
        }
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
            mapVC.view.frame.origin.y = toolbarVC.view.frame.maxY
        case .ended:
            if toolbar.frame.minY <= feedVC.view.frame.maxY / 2 || velocity.y < -300 {
                verticalPinConstraint?.deactivate()
                self.pinToolbarToTop()
                UIView.animate(withDuration: 0.3, animations: {
                    toolbar.frame.origin.y = self.navBarVC.view.frame.maxY - 1
                    self.mapVC.view.frame.origin.y = toolbar.frame.maxY
                    self.view.layoutIfNeeded()
                })
                self.mapIsShowing = false
            }
            if toolbar.frame.minY > feedVC.view.frame.maxY / 2 || velocity.y > 300 {
                verticalPinConstraint?.deactivate()
                self.pinToolbarToBottom()
                UIView.animate(withDuration: 0.3, animations: {
                    toolbar.frame.origin.y = self.feedVC.view.frame.maxY
                    self.mapVC.view.frame.origin.y = toolbar.frame.maxY
                    self.view.layoutIfNeeded()
                })
                self.mapIsShowing = true
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
    }
    
    // MARK: - Database networking
    
    
}

extension FeedMapParentViewController: FeedViewControllerDelegate {
    
}

extension FeedMapParentViewController: ToolbarViewControllerDelegate {
    func toolbar(_ toolbar: ToolbarViewController, selectedCategory category: Category) {
        
    }
    func toolbar(_ toolbar: ToolbarViewController, deselectedCategory category: Category) {
        
    }
}

extension FeedMapParentViewController: MapViewControllerDelegate {
    func mapView(_ mapView: MapViewController, didChangeLocation location: CLLocation) {
        
    }
}

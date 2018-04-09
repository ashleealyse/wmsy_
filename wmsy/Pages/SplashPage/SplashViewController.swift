//
//  SplashViewController.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleMaps

class SplashViewController: UIViewController {

    var splashView = SplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(splashView)
        scaled()
        
        guard let user = Auth.auth().currentUser else {
            print("some fuck up here i guess")
            return
        }
        
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = 50
        
        AppUser.configureCurrentAppUser(withUID: user.uid) {
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
        }
////        DBService.manager.getAppUser(fromID: user.uid, completion: { (appUser) in
////            if let appUser = appUser {
////                AppUser.currentAppUser = appUser
////                MenuData.manager.configureInitialData(forUser: appUser, completion: {
////                    print("set up everything already")
//                    (self.tabBarController as? MainTabBarVC)?.animateTo(page: .feedAndMap, fromViewController: self)
////                })
////            } else {
////                print("some other error here")
////            }
////        })
    }
    
    func scaled() {
        
        UIView.animate(withDuration: 3.0, animations: {
            self.splashView.logo.layer.transform = CATransform3DMakeScale(8, 8, 8)
        }, completion: { _ in
            UIView.animate(withDuration: 3.0, animations: {
                self.splashView.logo.layer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
            })
        })
        
    }
    
    private func setupObserversAndMenuDataForCurrentUser(completion: @escaping () -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("no current user")
            fatalError()
        }
        
        DBService.manager.getAppUser(fromID: user.uid) { (appUser) in
            guard let user = appUser else {
                print("no current app user")
                fatalError()
            }
            let group = DispatchGroup()
            group.enter()
            MenuData.manager.configureInitialData(forUser: user) {
                group.leave()
            }
            group.enter()
            MenuNotificationTracker.manager.setupListeners(forUser: user) {
                group.leave()
            }
            group.notify(queue: .main) {
                completion()
            }
        }
        
        
        
    }
}

extension SplashViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.setupObserversAndMenuDataForCurrentUser {
                (self.tabBarController as? MainTabBarVC)?.animateTo(page: .feedAndMap, fromViewController: self)
            }
        default:
            (self.tabBarController as? MainTabBarVC)?.animateTo(page: .login, fromViewController: self)
        }
    }
}


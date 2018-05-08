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

class LoadingScreen: UIViewController {
    
    @IBOutlet weak var wView: UILabel!
    @IBOutlet weak var mView: UILabel!
    @IBOutlet weak var sView: UILabel!
    @IBOutlet weak var yView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//            self.beginAnimation()
        animationCompletion = {
            //        self.toggleAnimation(UIButton(), {
            //            print(3)
            (self.tabBarController as? MainTabBarVC)?.animateTo(page: .feedAndMap, fromViewController: self)
            //        })
        }
            self.toggleAnimation(UIButton())
        guard let user = Auth.auth().currentUser else {
            print("some fuck up here i guess")
            return
        }
        
        AppUser.configureCurrentAppUser(withUID: user.uid) {
            self.toggleAnimation(UIButton())
        }
        
    }
    
    var isLoading: Bool = false
    func toggleAnimation(_ sender: UIButton, _ completion: @escaping () -> Void = {}) {
        if !isLoading {beginAnimation()}
        isLoading = !isLoading
    }
    var animationCompletion: () -> Void = {}
    func beginAnimation () {
        windUpRotateView(wView)
        windUpRotateView(mView, delay: 0.4)
        windUpRotateView(sView, delay: 0.8)
        windUpRotateView(yView, delay: 1.2) {
            if self.isLoading {self.beginAnimation()}
            else { self.animationCompletion() }
        }
    }
    
    func windUpRotateView(_ subview: UIView, delay: Double = 0.0, completion: @escaping () -> Void = {}) {
        UIView.animateKeyframes(withDuration: 1.25, delay: delay, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0 / 5.0, animations: {
                subview.transform = subview.transform.rotated(by: CGFloat.pi / -2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1.0 / 5.0, relativeDuration: 1.0 / 5.0, animations: {
                subview.transform = subview.transform.rotated(by: 5.0 * CGFloat.pi / 8.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2.0 / 5.0, relativeDuration: 1.0 / 5.0, animations: {
                subview.transform = subview.transform.rotated(by: 5.0 * CGFloat.pi / 8.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 3.0 / 5.0, relativeDuration: 1.0 / 5.0, animations: {
                subview.transform = subview.transform.rotated(by: 5.0 * CGFloat.pi / 8.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 4.0 / 5.0, relativeDuration: 1.0 / 5.0, animations: {
                subview.transform = subview.transform.rotated(by: 5.0 * CGFloat.pi / 8.0)
            })
        }) { (finished) in
            completion()
        }
    }

    public static func storyboardInstance() -> LoadingScreen {
        let storyboard = UIStoryboard(name: "LoadingScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoadingScreen") as! LoadingScreen
        return vc
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

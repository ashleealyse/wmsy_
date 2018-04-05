//
//  MainTabBarVC.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarVC: UITabBarController {
    
    let loginVC     = LoginVC()
    let splashScreen = SplashViewController()
    let feedMapVC   = UINavigationController.init(rootViewController: FeedMapVC())
    let chatRoomVC  =  UINavigationController.init(rootViewController: ChatRoomVCTest())
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loginVC.tabBarItem  = UITabBarItem(title: "login", image: nil, tag: 0)
        splashScreen.tabBarItem = UITabBarItem(title: "splash", image: nil, tag: 1)
        feedMapVC.tabBarItem = UITabBarItem(title: "feed", image: nil, tag: 2)
        chatRoomVC.tabBarItem = UITabBarItem(title: "chat room", image: nil, tag: 3)
        
        let controllers: [UIViewController] = [loginVC, splashScreen, feedMapVC, chatRoomVC]
        
        // comment to test with tab bar
        self.tabBar.isHidden = true
        self.setViewControllers(controllers, animated: false)
        
        // ### what screen to show if you're already signed in
        if Auth.auth().currentUser != nil {
            self.selectedIndex = 1
        }
//        if UserService.manager.userIsSignedIn() {
//            self.selectedIndex = 3
//        }
        self.moreNavigationController.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Helper functions
    public func viewController(for page: Page) -> UIViewController? {
        switch page {
        case .chatRoom:
            return chatRoomVC
        case .feedAndMap:
            return feedMapVC
        case .login:
            return loginVC
        case .splashScreen:
            return splashScreen
        }
    }
    
    public func animateTo(page: Page, fromViewController: UIViewController) {
        let toIndex = page.rawValue
        guard
            let tabViewControllers = viewControllers,
            let fromView = fromViewController.view,
            let toView = tabViewControllers[toIndex].view
            //            let fromIndex = tabViewControllers.index(of: selectedViewController!)
            //            fromIndex != toIndex
            else {
                return
        }
        var supremeView = toView
        while supremeView.superview != nil {
            supremeView = supremeView.superview!
        }
        
        
        fromView.superview?.addSubview(supremeView)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let offset = (page == .login) ? -screenWidth : screenWidth
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
        }) { (finished) in
            if self.view.window == nil {
                self.dismiss(animated: false, completion: nil)
            }
            
            fromView.removeFromSuperview()
            print(toIndex)
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        }
    }
    
}

extension MainTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers ?? []
        guard let toIndex = tabViewControllers.index(of: viewController) else {
            return false
        }
        
        //        animateTo(page: Page(rawValue: toIndex)!)
        animateTo(page: Page(rawValue: toIndex)!, fromViewController: selectedViewController!)
        
        return true
    }
}

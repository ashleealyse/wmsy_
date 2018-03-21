//
//  MainTabBarVC.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    let loginVC     = LoginVC()
    let feedMapVC   = UINavigationController.init(rootViewController: FeedMapVC())
    let chatRoomVC  = ChatRoomVC()
    
    
//    let createVC    = CreateAccountViewController()
//    let homeVC      = UINavigationController(rootViewController: HomeViewController())
//    let decksVC     = UINavigationController(rootViewController: DecksViewController())
//    let progressVC  = ProgressViewController()
//    let browseVC    = BrowseViewController()
//    let profileVC   = ProfileViewController()
//    let inboxVC     = InboxViewController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loginVC.tabBarItem  = UITabBarItem(title: "login", image: nil, tag: 0)
        feedMapVC.tabBarItem = UITabBarItem(title: "feed", image: nil, tag: 1)
        chatRoomVC.tabBarItem = UITabBarItem(title: "chat room", image: nil, tag: 2)
        
        let controllers: [UIViewController] = [loginVC, feedMapVC, chatRoomVC]
        
        // comment to test with tab bar
        self.tabBar.isHidden = true
        self.setViewControllers(controllers, animated: false)
        
        // ### what screen to show if you're already signed in
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
//        UserService.manager.userListener = self
        
        //        let loginVC     = LoginViewController()
        //        let createVC    = CreateAccountViewController()
        //        let homeVC      = HomeViewController()
        //        let studyVC     = StudyViewController()
        ////        let decksVC     = MyDecksCollectionViewController()
        //        let decksVC = TestCollection()
        
        //        loginVC.tabBarItem  = UITabBarItem(title: "login", image: nil, tag: 0)
        //        createVC.tabBarItem = UITabBarItem(title: "create", image: nil, tag: 1)
        //        homeVC.tabBarItem   = UITabBarItem(title: "home", image: nil, tag: 2)
        //        decksVC.tabBarItem  = UITabBarItem(title: "decks", image: nil, tag: 3)
        //        //        studyVC.tabBarItem  = UITabBarItem(title: "study", image: nil, tag: 3)
        //
        //        let homeNavVC = HiddenNavController(rootViewController: homeVC)
        //        let studyNavVC = HiddenNavController(rootViewController: studyVC)
        //
        ////        let loginNavVC = UINavigationController(rootViewController: loginVC)
        //
        //
        //        let controllers = [loginVC, createVC, homeVC, studyVC, decksVC]
        //        self.tabBar.isHidden = true
        //        self.setViewControllers(controllers, animated: false)
        // Do any additional setup after loading the view.
        
//        if UserService.manager.userIsSignedIn() {
//            selectedIndex = Page.home.rawValue
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Helper functions
    
    
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
        fromView.superview?.addSubview(toView)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let offset = (page == .login) ? -screenWidth : screenWidth
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
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

//extension MainTabBarVC: UserServiceListener {
//    func userSignedOut() {
//        guard selectedIndex != Page.login.rawValue else { return }
//        //        for vc in viewControllers {
//        //            if let vc =
//        //        }
//        if let vc = selectedViewController as? MenuedViewController {
//            if vc.view.window != nil {
//                print("listener")
//                animateTo(page: .login, fromViewController: selectedViewController!)
//            }
//        }
//
//
//    }
//}

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

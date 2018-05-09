    //
//  AppDelegate.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import GoogleMaps
import SnapKit
    
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyDoVxDTMUODq896Vbusf_6Al7u4PHc95cw")
        
        let vc = MainTabBarVC()
//        let vc = FeedMapParentViewController()
//        let vc = LoadingScreen.storyboardInstance()
        vc.navigationItem.backBarButtonItem?.image = #imageLiteral(resourceName: "backIcon")
        vc.navigationItem.backBarButtonItem?.tintColor = Stylesheet.Colors.WMSYKSUPurple
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        LoginManager().logOut()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

    class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        lazy var tableView: UITableView = {
            let tv = UITableView(frame: .zero, style: .grouped)
            tv.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
            return tv
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(tableView)
            self.edgesForExtendedLayout = []
            tableView.snp.makeConstraints { (make) in
                make.edges.equalTo(self.view)
            }
//            self.edgesForExtendedLayout = []
            tableView.contentInsetAdjustmentBehavior = .never
            print(tableView.safeAreaInsets)
            tableView.estimatedRowHeight = 2.0
//            tableView.estimatedSectionHeaderHeight = 0
//            tableView.estimatedSectionFooterHeight = 0
            tableView.dataSource = self
            tableView.delegate = self
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 4
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 20
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "test"
        }
        func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
            return "test"
        }
//        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 0.0
//        }
//        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//            return 0.0
//        }
    }

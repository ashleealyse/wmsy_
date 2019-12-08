//
//  FeedViewController.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feed = FeedView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(feed)
        feed.feedTableView.dataSource = self
        feed.feedTableView.delegate = self
        feed.filterBar.delegate = self
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
         return UIStatusBarStyle.lightContent
    }

}




extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell at row: \(indexPath.row)")
    }
}


extension FeedViewController: FilterBarDelegate {
    func filterPressed(filterPressed: String) {
        print("filter pressed at \(filterPressed)")
    }
    
    func clearPressed() {
        print("clear pressed")
    }
    
    
}

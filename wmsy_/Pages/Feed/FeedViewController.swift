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
        //view.backgroundColor = .white
        view.addSubview(feed)
        feed.feedTableView.dataSource = self
        feed.feedTableView.delegate = self
        feed.filterBar.delegate = self
        feed.bottomConstraint(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
         return UIStatusBarStyle.lightContent
    }

}




extension FeedViewController: UITableViewDataSource, UITableViewDelegate, CardCellDelegate {
    
    func profilePressed() {
        let profile = ProfileViewController()
        present(profile, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.delegate = self
        if indexPath.row % 2 == 0 {
        cell.backgroundImage.image = UIImage(named: "pet")?.darkened()
        } else {
            cell.backgroundImage.image =  UIImage(named: "sports")?.darkened()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell at row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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



//
//  FeedMapVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FeedMapVC: MenuedViewController {
    
    var feedView = FeedView()
    var expandedRows = Set<Int>()
    
    var feedWhims: [Whim] = [] {
        didSet {
            feedWhims = feedWhims.sortedByTimestamp()
            feedView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBService.manager.getAllWhims { (onlineWhims) in
            self.feedWhims = onlineWhims
        }
        
        view.addSubview(feedView)
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        feedView.tableView.register(FeedCell.self, forCellReuseIdentifier: "WhimFeedCell")
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
        feedView.tableView.estimatedRowHeight = 90
        feedView.tableView.separatorStyle = .none

        configureNavBar()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        feedView.tableView.reloadData()
    }
    
    // setup UIBarButtonItem
    private func configureNavBar() {
        //        navigationItem.title = "wmsy"
        // top left bar button item to Host a Whim (popsicles with a + symbol?)
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem
        navigationItem.title = "wmsy"
    }
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FeedMapVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
                return
        }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        default:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension FeedMapVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedWhims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.collapsedView.wmsyTitle.text = whim.title
        cell.collapsedView.categoryImage.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
//        cell.collapsedView.userImage.image =
        // path for the category image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        
        
        cell.expandedView.wmsyTitle.text = whim.title
        cell.expandedView.categoryImage.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
//        cell.expandedView.wmsyDescription.text = whim.description
        
//        cell.expandedView.userImage.image =
        // path for the category image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        return cell
    }
}

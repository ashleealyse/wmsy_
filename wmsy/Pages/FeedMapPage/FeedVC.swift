//
//  FeedVC.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

//protocol ParentDelegate: class {
//    public func updateChildren(whims: [Whim]) -> Void
//}

class FeedVC: UIViewController {

    var feedView = FeedView()
    
    var feedWhims: [Whim] = []
    
    var expandedRows = Set<Int>()
    
    weak var delegate: ParentDelegate?
    
//    // takes in Whims, updates local whim array
//    public func update(withWhims: [Whim]) {
//        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
//            self.feedWhims = whims
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        view.addSubview(feedView)
        
//        feedView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }

        feedView.tableView.register(FeedCell.self, forCellReuseIdentifier: "WhimFeedCell")
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
        feedView.tableView.estimatedRowHeight = 90
        feedView.tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
            return
        }
        
//        switch cell.isExpanded {
//        case true:
//            self.expandedRows.remove(indexPath.row)
//        default:
//            self.expandedRows.insert(indexPath.row)
//        }
//
        cell.isExpanded = !cell.isExpanded
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension FeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedWhims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.collapsedView.postTitleLabel.text = whim.title
        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        //        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: whim.)
        
        
        cell.expandedView.postDescriptionTF.text = whim.description
        return cell
    }
}


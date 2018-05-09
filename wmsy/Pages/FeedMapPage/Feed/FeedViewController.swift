//
//  FeedViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedViewControllerDelegate: class {
    func feedView(_ feedView: FeedViewController, requestingUpdate request: Bool) -> Void
    func feedView(_ feedView: FeedViewController, tappedUserProfile userID: String) -> Void
    func feedView(_ feedView: FeedViewController, tappedInterestButton whim: Whim) -> Void
    func feedView(_ feedView: FeedViewController, tappedShowOnMapButton whim: Whim) -> Void
}

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    var expandedRows = Set<Int>()
    var delegate: FeedViewControllerDelegate?
    
    private var whims = [Whim]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(feedView)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        
        // TODO: fix this jittery trash
        // it's suposed to have the refresh control show on first load
        // problems:
        // -shows a have rendered version of the control
        // -tint color hasn't take effect here yet for some reason
        let point = CGPoint.init(x: 0, y: -feedView.refreshControl.frame.height)
        self.feedView.tableView.contentOffset = CGPoint.init(x: 0, y: -1)
        self.feedView.tableView.contentOffset = CGPoint.zero
        self.feedView.tableView.setContentOffset(point, animated: true)
        self.feedView.refreshControl.beginRefreshing()
        self.feedView.refreshControl.addTarget(self, action: #selector(refreshControlDragged), for: UIControlEvents.valueChanged)
    }
    
    @objc private func refreshControlDragged() {
        if !feedView.tableView.isDragging {
            refreshData()
        }
    }
    private func refreshData() {
        guard let delegate = delegate else {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.feedView.refreshControl.blink()
                self.feedView.refreshControl.endRefreshing()
            }
            return
        }
        delegate.feedView(self, requestingUpdate: true)
    }
    public func updateWhimsTo(_ whims: [Whim]) {
        guard self.whims != whims else {return}
        self.whims = whims.sortedByTimestamp()
        if self.feedView.refreshControl.isRefreshing {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.feedView.refreshControl.blink()
                self.feedView.refreshControl.endRefreshing()
                self.feedView.tableView.reloadData()
            }
        } else {
            self.feedView.tableView.reloadData()
        }
    }
    
    @objc func tappedUserProfile(_ button: UIButton) {
        if let cell = button.superview?.superview?.superview?.superview as? FeedCell2,
            let whim = cell.whim {
            self.delegate?.feedView(self, tappedUserProfile: whim.hostID)
        }
    }
    @objc func tappedShowInterest(_ button: UIButton) {
        if let cell = button.superview?.superview?.superview?.superview as? FeedCell2,
            let whim = cell.whim {
            delegate?.feedView(self, tappedInterestButton: whim)
            DispatchQueue.main.async {
                guard let interests = AppUser.currentAppUser?.getInterestKeys() else {return}
                if interests.contains(whim.id){
                    button.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.5)
                    button.setTitle("Remove Interest", for: .normal)
                }else{
                    button.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
                    button.setTitle("Show Interest", for: .normal)
                }
            }
        }
    }
    @objc func tappedShowOnMap(_ button: UIButton) {
        if let cell = button.superview?.superview?.superview?.superview as? FeedCell2,
            let whim = cell.whim {
            delegate?.feedView(self, tappedShowOnMapButton: whim)
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell2
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        cell.collapsedView.userImageButton.addTarget(self, action: #selector(tappedUserProfile(_:)), for: .touchUpInside)
        cell.expandedView.interestedButton.addTarget(self, action: #selector(tappedShowInterest(_:)), for: .touchUpInside)
        cell.expandedView.showOnMapButton.addTarget(self, action: #selector(tappedShowOnMap(_:)), for: .touchUpInside)
        let whim = whims[indexPath.row]
        cell.whim = whim
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as? FeedCell2 else { return }
        let whim = whims[indexPath.row]
        cell.whim = whim
    }
}

extension FeedViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if feedView.refreshControl.isRefreshing {
            refreshData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell2 else {
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
        UIView.animate(withDuration: 0.3) {
            cell.layoutIfNeeded()
        }
        tableView.endUpdates()
    }
}

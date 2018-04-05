//
//  File.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuChatsListVCDelegate: class {
    func didSelect(whim: Whim) -> Void
}

class MenuChatsListVC: UIViewController {
    
    let chatsListTableView = UITableView()
    let noDataOverlay = UIView()
    let noDataLabel = UILabel()
    private var hostedWhims = [(whim: Whim, hasNotification: Bool)]()
    private var guestWhims = [(whim: Whim, hasNotification: Bool)]()
    private var pendingInterests = [(interest: Interest, title: String)]()
    private var noData: Bool {
        return hostedWhims.isEmpty && guestWhims.isEmpty && pendingInterests.isEmpty
    }
    
    weak var delegate: MenuChatsListVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chatsListTableView)
        
        chatsListTableView.register(MenuWhimsHeader.self, forHeaderFooterViewReuseIdentifier: MenuWhimsHeader.reuseIdentifier)
        chatsListTableView.register(MenuWhimsCell.self, forCellReuseIdentifier: MenuWhimsCell.reuseIdentifier)
        
        chatsListTableView.dataSource = self
        chatsListTableView.delegate = self
        chatsListTableView.rowHeight = UITableViewAutomaticDimension
        chatsListTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        chatsListTableView.estimatedSectionHeaderHeight = 50
        chatsListTableView.estimatedRowHeight = 50
        
        
        
        chatsListTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        noDataOverlay.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        
        view.addSubview(noDataOverlay)
        noDataOverlay.snp.makeConstraints { (make) in
            make.edges.equalTo(chatsListTableView)
        }
        
        noDataLabel.numberOfLines = 0
        noDataLabel.text = "there's nothing here...try browsing for something to do"
        noDataLabel.textColor = Stylesheet.Colors.WMSYKSUPurple
        
        noDataOverlay.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { (make) in
            make.center.equalTo(noDataOverlay)
            make.leading.trailing.equalTo(noDataOverlay).inset(50)
        }
    }
    
    public func configureWith(hostedWhims: [(Whim, Bool)], guestWhims: [(Whim, Bool)], pendingInterests: [(Interest, String)]) {
        self.hostedWhims = hostedWhims
        self.guestWhims = guestWhims
        self.pendingInterests = pendingInterests
        chatsListTableView.reloadData()
        noDataOverlay.isHidden = !noData
    }
}

extension MenuChatsListVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        if !hostedWhims.isEmpty {sectionCount += 1}
        if !guestWhims.isEmpty {sectionCount += 1}
        if !pendingInterests.isEmpty {sectionCount += 1}
        return sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
                return hostedWhims.count
        case 1:
                return guestWhims.count
        case 2:
                return pendingInterests.count
            
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuWhimsHeader.reuseIdentifier) as! MenuWhimsHeader
        switch section {
        case 0:
                header.titleLabel.text = "Hosted Whims"
        case 1:
                header.titleLabel.text = "Guest Whims"
        case 2:
                header.titleLabel.text = "Pending Whims"
        default:
            break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuWhimsCell.reuseIdentifier, for: indexPath) as! MenuWhimsCell
        let setupFromHostedWhims: () -> () = { [unowned self] in             let whim = self.hostedWhims[indexPath.row].whim
            let hasNotif = self.hostedWhims[indexPath.row].hasNotification
            cell.whimTitle.text = whim.title
            if hasNotif {
                cell.whimTitle.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            } else {
                cell.whimTitle.font = UIFont.systemFont(ofSize: 23)
            }
        }
        let setupFromGuestWhims: () -> () = { [unowned self] in
            let whim = self.guestWhims[indexPath.row].whim
            let hasNotif = self.guestWhims[indexPath.row].hasNotification
            cell.whimTitle.text = whim.title
            if hasNotif {
                cell.whimTitle.font = UIFont.systemFont(ofSize: 23, weight: .bold)
            } else {
                cell.whimTitle.font = UIFont.systemFont(ofSize: 23)
            }
        }
        let setupFromPendingInterests: () -> () = { [unowned self] in
            let title = self.pendingInterests[indexPath.row].title
            cell.whimTitle.text = title
        }
        
        switch indexPath.section {
        case 0:
                setupFromHostedWhims()
            
        case 1:
                setupFromGuestWhims()
        case 2:
                setupFromPendingInterests()
            
        default:
            break
        }
        return cell
    }
    // MARK: - Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let whim = hostedWhims[indexPath.row].whim
            delegate?.didSelect(whim: whim)
        case 1:
            let whim = guestWhims[indexPath.row].whim
            delegate?.didSelect(whim: whim)
        case 2:
            return
        default:
            return
        }
    }
}


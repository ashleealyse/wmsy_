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
    private var hostedWhims = [Whim]()
    private var guestWhims = [Whim]()
    private var pendingInterests = [Interest]()
    
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
    }
    
    public func configureWith(hostedWhims: [Whim], guestWhims: [Whim], pendingInterests: [Interest]) {
        self.hostedWhims = hostedWhims
        self.guestWhims = guestWhims
        self.pendingInterests = pendingInterests
        chatsListTableView.reloadData()
    }
}

extension MenuChatsListVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        switch indexPath.section {
        case 0:
            let whim = hostedWhims[indexPath.row]
            cell.whimTitle.text = whim.title
        case 1:
            let whim = guestWhims[indexPath.row]
            cell.whimTitle.text = whim.title
        case 2:
            let interest = pendingInterests[indexPath.row]
            cell.whimTitle.text = interest.whimID
        default:
            break
        }
        return cell
    }
    // MARK: - Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let whim = hostedWhims[indexPath.row]
            delegate?.didSelect(whim: whim)
        case 1:
            let whim = guestWhims[indexPath.row]
            delegate?.didSelect(whim: whim)
        case 2:
            return
        default:
            return
        }
    }
}


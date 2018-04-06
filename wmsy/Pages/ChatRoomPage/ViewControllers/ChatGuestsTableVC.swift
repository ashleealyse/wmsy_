//
//  ChatGuestsTableVC.swift
//  wmsy
//
//  Created by C4Q on 4/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol ChatGuestsTableVCDelegate: class {
    func updateMembers(members: [AppUser])
    func addInterestedUser(_ user: AppUser)
    func removeUser(_ user: AppUser)
}

class ChatGuestsTableVC: UITableViewController {

    init(members: [AppUser], inChat: [String: Bool]) {
        super.init(nibName: nil, bundle: nil)
        
        self.members = members
        self.configureWith(members: members, andPermissions: inChat)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var currentWhim: Whim?
    
    private var members = [AppUser]()
    
    public var lastMemberID: String? {return members.last?.userID}
    public var inChat = [String: Bool]()
    
    private var currentSelectedUser: AppUser? {
        didSet {
            print("Current Selected User: \(currentSelectedUser?.name ?? "No current user")")
        }
    }
    
    public func configureWith(members: [AppUser], andPermissions permissions: [String: Bool]) {
        // TODO: get list of members
        self.members = members
        self.inChat = permissions
//        membersCollectionView?.reloadData()
    }
    
    public func configureWith(_ whim: Whim) {
        self.currentWhim = whim
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func new(interestedUser user: AppUser) {
        members.append(user)
        inChat[user.userID] = false
    }
    public func invited(_ user: AppUser) {
        inChat[user.userID] = true
    }
    public func removed(_ user: AppUser) {
        guard let index = members.index(where: {$0.userID == user.userID}) else {
            print("wasn't a user in here")
            fatalError()
        }
        members.remove(at: index)
        inChat[user.userID] = nil
    }
    
    public weak var delegate: InfoAndMembersCollectionVCDelegate?
    
    @objc func inviteButtonHit() {
        
        guard
            let user = currentSelectedUser,
            let inChat = inChat[user.userID] else {
                return
        }
        if inChat {
            delegate?.removeUser(user)
        } else {
            delegate?.addInterestedUser(user)
        }
    }
    
    @objc func showMapButtonHit() {
        print("Show this Whim on the map")
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        // in chat
        case 0:
            return inChat.count
        // interested
        case 1:
            return members.count - inChat.count
        default:
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "guestCell")
        let member = members[indexPath.row]
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.bio
        
        let userImageString = member.photoID
        let userImageUrl = URL(string: userImageString)
        cell.imageView?.kf.setImage(with: userImageUrl)

        return cell
    }
}

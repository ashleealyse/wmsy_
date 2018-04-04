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
//        self.membersCollectionView?.reloadData()
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
//            memberInfoView.inviteButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
//            memberInfoView.inviteButton.setTitle("Remove", for: .normal)
        }
//        self.membersCollectionView?.reloadData()
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "guestCell")
        let member = members[indexPath.row]
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.bio
        
        let userImageString = member.photoID
        let userImageUrl = URL(string: userImageString)
        cell.imageView?.kf.setImage(with: userImageUrl)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

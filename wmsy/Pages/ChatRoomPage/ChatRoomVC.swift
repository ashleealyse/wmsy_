//
//  ChatRoomTVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ChatRoomVC: MenuedViewController {

    var hostChatView = HostChatView()
    var guestChatView = GuestChatView()
    var numberOfGuests = 5
    var guests = [AppUser]()
//    var currentSelectedGuest = AuthUserService.manager.getCurrentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(hostChatView)
        
        hostChatView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        /// populate guest list with current app user and then interested guests
//        guests = 
        
        configureNavBar()
        
        hostChatView.interestedGuestsCV.dataSource = self
        hostChatView.interestedGuestsCV.delegate = self
        
        hostChatView.sendChatButton.addTarget(self, action: #selector(sendChatMessage), for: .touchUpInside)
        
        hostChatView.goOnAWhimButton.addTarget(self, action: #selector(goOnAWhim), for: .touchUpInside)

    }

    private func configureNavBar() {
        navigationItem.title = "Chat Room"
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leaveChatIcon"), style: .plain, target: self, action: #selector(leaveChat))
        navigationItem.rightBarButtonItem = topRightBarItem
    }
    
    @objc func leaveChat() {
        print("current user leaves chat. If Host, delete Chat. If Guest, remove from Whim")
    }
    
    @objc func sendChatMessage() {
        print("send chat message button pressed")
    }
    
    
    @objc func goOnAWhim() {
        print("Go on a whim: Lock guest list, remove from Feed, expose location")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


extension ChatRoomVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfGuests
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGuestCell", for: indexPath) as! ChatGuestCollectionViewCell
///                let currentGuestImageString = guests[indexPath.row].photoID
        let guestImage = UIImage(named: "wmsyCategoryIcon")
///        let currentGuestImageURL = URL(string: "\(currentGuestImageString)")
///        cell.guestImageView.kf.setImage(with: currentGuestImageURL)
        cell.guestImageView.image = guestImage
        cell.guestImageView.kf.indicatorType = .activity
        return cell
    }
}


extension ChatRoomVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChatGuestCollectionViewCell
        let guest = guests[indexPath.row]
        var selectedGuest = guest
//        currentSelectedGuest = selectedGuest
        
    }
    
}

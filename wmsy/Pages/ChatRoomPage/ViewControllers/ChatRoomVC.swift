////
////  ChatRoomTVC.swift
////  wmsy
////
////  Created by C4Q on 3/15/18.
////  Copyright © 2018 C4Q. All rights reserved.
////
//
//import UIKit
//import SnapKit
////<<<<<<< HEAD
//
//class ChatRoomVC: MenuedViewController {
//    
//    let chatView = ChatView()
//    var whim: Whim?
//    var messages: [Message] = [] {
//        didSet {
//            chatView.chatTableView.reloadData()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // TODO: Populate with whim chat info
//        view.addSubview(chatView)
//        chatView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
////        whim = Whim.init(id: "12341234", category: "12341234", title: "12341234", description: "12341234", hostID: "12341234", approxLocation: "12341234", location: "12341234", duration: 12341234)
////        whim = Whim.init(id: "12341234", category: "12341234", title: "12341234", description: "12341234", hostID: "12341234", location: "12341234", long: "12341234", lat: "12341234", duration: 24, expiration: "12341234", finalized: false, timestamp: "12341234", whimChats: [])
////        whim = Whim.init(id: "13241234", category: "12341234", title: "12341234", description: "12341234", hostID: "12341234", location: "13241234", duration: 1234134, finalized: false, timestamp: "13241234", whimChats: [])
//        whim = Whim.init(id: "12341234", category: "12341234", title: "12341234", description: "12341234", hostID: "13241234", hostImageURL: "12341234", location: "12341234", long: "12341234", lat: "12341234", duration: 12341234, expiration: "12342341", finalized: false, timestamp: "12341234", whimChats: [])
//        setupTableView()
//        DataQueue.manager.delegate = self
////        loadInitialData()
//        DataQueue.manager.startSendingData()
//    }
//    private func setupTableView() {
//        chatView.chatTableView.dataSource = self
//        chatView.chatTableView.delegate = self
//    }
//    private func loadInitialData() {
//        // TODO: get this triggered by listener instead
////        loadDummyData()
////        chatView.chatTableView.reloadData()
//    }
//    private func loadDummyData() {
//        for _ in 0..<200 {
//            let types: [MessageType] = [.chat, .button, .notification]
//            let randIndex = Int(arc4random_uniform(3))
//            let message = Message.init(whimID: "12341324", messageID: "12341234", senderID: "12341234", timestamp: "12341234", messageType: types[randIndex], messageBody: "aidfnaoidsufoiudh")
//            whim?.whimChats.append(message)
//        }
////=======
////import Kingfisher
////
////class ChatRoomVC: MenuedViewController {
////
////    var hostChatView = HostChatView()
////    var guestChatView = GuestChatView()
////    var numberOfGuests = 5
////    var guests = [AppUser]()
//////    var currentSelectedGuest = AuthUserService.manager.getCurrentUser()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        view.addSubview(hostChatView)
////
////        hostChatView.snp.makeConstraints { (make) in
////            make.edges.equalTo(view.safeAreaLayoutGuide)
////        }
////
////        /// populate guest list with current app user and then interested guests
//////        guests =
////
////        configureNavBar()
////
////        hostChatView.interestedGuestsCV.dataSource = self
////        hostChatView.interestedGuestsCV.delegate = self
////
////        hostChatView.sendChatButton.addTarget(self, action: #selector(sendChatMessage), for: .touchUpInside)
////
////        hostChatView.goOnAWhimButton.addTarget(self, action: #selector(goOnAWhim), for: .touchUpInside)
////
////    }
////
////    private func configureNavBar() {
////        navigationItem.title = "Chat Room"
////
////        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "leaveChatIcon"), style: .plain, target: self, action: #selector(leaveChat))
////        navigationItem.rightBarButtonItem = topRightBarItem
////    }
////
////    @objc func leaveChat() {
////        print("current user leaves chat. If Host, delete Chat. If Guest, remove from Whim")
////    }
////
////    @objc func sendChatMessage() {
////        print("send chat message button pressed")
////    }
////
////
////    @objc func goOnAWhim() {
////        print("Go on a whim: Lock guest list, remove from Feed, expose location")
////>>>>>>> qa
//    }
//}
//
////<<<<<<< HEAD
//extension ChatRoomVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
////        return whim?.whimChats.count ?? 0
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let message = messages[indexPath.row]
//        switch message.messageType {
//        case .chat:
//            // TODO: check if whim userid is the current userid,
//            // not if the indexpath.row is even or not
//            if indexPath.row % 2 == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: ChatView.hostCell, for: indexPath) as? CurrentUserMessageCell
//                return cell ?? UITableViewCell()
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: ChatView.guestCell, for: indexPath) as? OtherUserMessageCell
//                return cell ?? UITableViewCell()
//            }
//        case .notification:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ChatView.notifCell, for: indexPath) as? NotificationTableViewCell
//            return cell ?? UITableViewCell()
//        case .button:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ChatView.locCell, for: indexPath) as? LocationDetailsTableViewCell
//            return cell ?? UITableViewCell()
//        }
//    }
////=======
////
////extension ChatRoomVC: UICollectionViewDataSource {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return numberOfGuests
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGuestCell", for: indexPath) as! ChatGuestCollectionViewCell
///////                let currentGuestImageString = guests[indexPath.row].photoID
////        let guestImage = UIImage(named: "wmsyCategoryIcon")
///////        let currentGuestImageURL = URL(string: "\(currentGuestImageString)")
///////        cell.guestImageView.kf.setImage(with: currentGuestImageURL)
////        cell.guestImageView.image = guestImage
////        cell.guestImageView.kf.indicatorType = .activity
////        return cell
////    }
////}
////
////
////extension ChatRoomVC: UICollectionViewDelegate {
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let cell = collectionView.cellForItem(at: indexPath) as! ChatGuestCollectionViewCell
////        let guest = guests[indexPath.row]
////        var selectedGuest = guest
//////        currentSelectedGuest = selectedGuest
////        
////    }
////    
////>>>>>>> qa
//}
//
//extension ChatRoomVC: DataReceiver {
//    func accept(message: Message?) {
//        guard let message = message else { return }
//        messages.append(message)
//    }
//}
//
//

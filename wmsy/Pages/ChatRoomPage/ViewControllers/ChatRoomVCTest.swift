//
//  ChatRoomVCTest.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

//extension UIViewController {
//    func add(_ child: UIViewController) {
//        addChildViewController(child)
//        view.addSubview(child.view)
//        child.didMove(toParentViewController: self)
//    }
//    func remove() {
//        guard parent != nil else {
//            return
//        }
//        willMove(toParentViewController: nil)
//        removeFromParentViewController()
//        view.removeFromSuperview()
//    }
//}


class ChatRoomVCTest: MenuedViewController {
    
    let mainScrollView = UIScrollView()
    let membersCollectionVC = InfoAndMembersCollectionVC()
    let chatTVC = ChatMessagesTableVC()
    let textInputVC = TextInputVC()
    
//    private var whim = Whim.init(id: "-L8JoE-G-U1uGGYyt4X5", category: "wmsy", title: "Pictures please", description: ":D", hostID: "mdH6CJXxDkYBqhfjjptVnTpMp3g2", hostImageURL: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/29366139_128316311338085_2672539358371774464_n.jpg?_nc_cat=0&oh=3df47771fb34edb538211510eaa9dff9&oe=5B4431F0", location: "142 West 46th Street New York, NY 10036", long: "-73.9841802790761", lat: "40.7578242106358", duration: 2, expiration: "March 23, 2018 at 7:43:21 PM EDT", finalized: false, timestamp: "March 23, 2018 at 5:43:21 PM EDT", whimChats: [])
    private var whim: Whim?
    private var currentUserID: String { return AuthUserService.manager.getCurrentUser()?.uid ?? "" }
    private var interests = [Interest]()
    private var interestedUsers = [AppUser]()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.add(membersCollectionVC)
        self.add(chatTVC)
        self.add(textInputVC)
        
        membersCollectionVC.delegate = self
        chatTVC.delegate = self
        textInputVC.delegate = self
        
        chatTVC.configureWith(whim!)
        
        setupSubviewsConstraints()
        setupKeyboardHandling()
        
        DataQueue.manager.delegate = self
        DataQueue.manager.startSendingData()
    }
    private func setupSubviewsConstraints() {
//        This page is comprised of 3 sections:
//        a controlling collection view on top
//        a tableview that displays messages
//        a text input section at the bottom
//
//        the collection view and text input view have intrinsic heights
//        the tableview stretches based on its contraints to fit everything
//        on one screen
        
        membersCollectionVC.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
        }
        chatTVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(membersCollectionVC.view.snp.bottom)
            make.leading.trailing.equalTo(self.view)
        }
        textInputVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(chatTVC.view.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view)
        }
    }
    
    private func setupKeyboardHandling() {let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc private func adjustForKeyboard(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        UIView.animate(withDuration: 0.4) {
            self.view.frame.size.height = keyboardScreenEndFrame.origin.y
            self.view.layoutIfNeeded()
        }
        chatTVC.scrollToBottom(animated: true)
    }
    
    // To be called anytime a (different) chat is being presented
    public func loadAllInitialData(forWhim whim: Whim) {
        if self.whim != nil {
            guard whim.id != self.whim!.id else {
                    return
            }
        }
        
        self.whim = whim
        // TODO: get all whim messages
        DBService.manager.getAllMessages(forWhim: whim) { (messages) in
            self.whim!.whimChats = messages
            self.chatTVC.configureWith(self.whim!)
        }
        // TODO: get all interests associated with the whim
        DBService.manager.getAllInterests(forWhim: whim) { (interests) in
            self.interests = interests
            var interestDict = [String: Bool]()
            for interest in interests {
                interestDict[interest.userID] = interest.inChat
            }
            
            // TODO: get all user info for interested users
            let userIDs = interests.map{$0.userID}
            DBService.manager.getAppUsers(fromList: userIDs) { (users) in
                self.interestedUsers = users
                self.membersCollectionVC.configureWith(members: users, andPermissions: interestDict)
            }
        }
        
        // TODO: hand off that data to childVCs
    }
    public func setupObservers() {
        
    }
}

// MARK: - childVCs delegate methods implementation
extension ChatRoomVCTest: ChatMessagesTableVCDelegate, TextInputVCDelegate, InfoAndMembersCollectionVCDelegate {
    func toggleUser(user: AppUser) {
        print("ChatRoomVCTest - user: \(user)")
    }
    
    func send(message: String) {
        let message = Message.init(whimID: whim!.id, messageID: "12341234", senderID: currentUserID, messageType: .chat, messageBody: message)
        // TODO: make the message using the message service thing so that we can get a real id for it before passing it off to the tableview
        chatTVC.new(message: message)
        DBService.manager.addMessage(text: message.messageBody, ofType: .chat, fromUserID: currentUserID, toWhim: whim!)
//        DBService.manager.addInterest(forWhim: whim!)
    }
}

extension ChatRoomVCTest: DataReceiver {
    func accept(message: Message?) {
        guard let message = message else {
            return
        }
        chatTVC.new(message: message)
    }
}





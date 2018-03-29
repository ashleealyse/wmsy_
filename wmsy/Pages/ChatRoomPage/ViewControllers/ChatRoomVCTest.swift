//
//  ChatRoomVCTest.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase


class ChatRoomVCTest: MenuedViewController {
    
    let mainScrollView = UIScrollView()
    let membersCollectionVC = InfoAndMembersCollectionVC()
    let chatTVC = ChatMessagesTableVC()
    let textInputVC = TextInputVC()
    
    private var whim: Whim?
    public var whimID: String? {return whim?.id}
    private var currentUserID: String { return AuthUserService.manager.getCurrentUser()?.uid ?? "" }
    private var interests = [Interest]()
    private var interestedUsers = [AppUser]()
    
    private var members = [AppUser]() {
        didSet {
            print("members: \(members)")
        }
    }
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
        
        membersCollectionVC.memberInfoView.delegate = self
        
        setupSubviewsConstraints()
        setupKeyboardHandling()
        
        DataQueue.manager.delegate = self
        DataQueue.manager.startSendingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
        chatTVC.configureWith(whim!)
        membersCollectionVC.configureWith(whim!)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        detachObservers()
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
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        chatTVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(membersCollectionVC.view.snp.bottom)
            make.leading.trailing.equalTo(self.view)
        }
        textInputVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(chatTVC.view.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.greaterThanOrEqualTo(64)
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
    private var messageHandler: DatabaseReference!
    public func setupObservers() {
        guard let whim = whim else { return }
        messageHandler = DBService.manager.messagesRef.child(whim.id)
        messageHandler.queryLimited(toLast: 1).observe(.childAdded) { (snapshot) in
            guard
                var messageDict = snapshot.value as? [String: Any] else {
                    print(snapshot.key)
                    return
            }
            messageDict["whimID"] = whim.id
            messageDict["messageID"] = snapshot.key
            if let message = Message.init(fromDict: messageDict),
                message.messageID != self.chatTVC.lastMessageID {
                self.whim!.whimChats.append(message)
                self.chatTVC.new(message: message)
            }
        }
    }
    private func detachObservers() {
        messageHandler.removeAllObservers()
    }
}

// MARK: - childVCs delegate methods implementation
extension ChatRoomVCTest: ChatMessagesTableVCDelegate, TextInputVCDelegate, InfoAndMembersCollectionVCDelegate {
    func updateMembers(members: [AppUser]) {
        self.members = members
    }
    
    func toggleUser(user: AppUser) {
        print("ChatRoomVCTest - user: \(user)")
    }
    
    func send(message: String) {
        DBService.manager.addMessage(text: message, ofType: .chat, fromUserID: currentUserID, toWhim: whim!)
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


extension ChatRoomVCTest: ChatInfoViewDelegate {
    func inviteOrRemoveUserPressed(sender: UIButton) {
        let index = sender.tag
        let member = members[index]
        let interests = member.interests.filter{$0.whimID == whimID}
        if interests[0].inChat {
            removeFromWhimChat(member: member)
        } else {
            inviteToWhimChat(member: member)
        }
        print("Member Modified: \(member.name)")
    }
    
    func inviteToWhimChat(member: AppUser) {
        print("invite to chat: \(member.name)")
    }
    func removeFromWhimChat(member: AppUser) {
        print("remove from chat: \(member.name)")
    }
    
}


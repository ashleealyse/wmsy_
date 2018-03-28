//
//  ChatMessagesTableVC.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

protocol ChatMessagesTableVCDelegate: class {
    
}

class ChatMessagesTableVC: UIViewController {
    
    let chatTableView = UITableView()
    private var messages = [Message]()
    private var currentUserID: String {return AuthUserService.manager.getCurrentUser()?.uid ?? ""}
    
    public weak var delegate: ChatMessagesTableVCDelegate?
    
    public func configureWith(_ whim: Whim) {
        self.messages = whim.whimChats
        print(messages.count)
        chatTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(chatTableView)
        
        // setup tableview
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.register(CurrentUserMessageCell.self, forCellReuseIdentifier: CurrentUserMessageCell.reuseIdentifier)
        chatTableView.register(OtherUserMessageCell.self, forCellReuseIdentifier: OtherUserMessageCell.reuseIdentifier)
        chatTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)
        chatTableView.register(LocationDetailsTableViewCell.self, forCellReuseIdentifier: LocationDetailsTableViewCell.reuseIdentifier)
        
        chatTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 100
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false
        chatTableView.backgroundColor = .clear
    }
    
    public func new(message: Message) {
        let cellCount = messages.count
        messages.append(message)
        let newCellIndexPath = IndexPath(row: cellCount, section: 0)
        chatTableView.insertRows(at: [newCellIndexPath], with: .automatic)
        
        // scroll with messages if last visible cell is last message
        if let indexOfLastVisibleCell = chatTableView.indexPathsForVisibleRows?.last,
            indexOfLastVisibleCell.row == messages.count - 2 {
            scrollToBottom(animated: true)
//            chatTableView.scrollToRow(at: newCellIndexPath, at: .bottom, animated: true)
        }
    }
    public func scrollToBottom(animated: Bool) {
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        guard indexPath.row >= 0 else {return}
        chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
}

extension ChatMessagesTableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        print(message.senderID ?? "")
        switch message.messageType {
        case .chat:
            if message.senderID == self.currentUserID {
                let cell = tableView.dequeueReusableCell(withIdentifier: CurrentUserMessageCell.reuseIdentifier, for: indexPath) as! CurrentUserMessageCell
                if message.messageBody != "aidfnaoidsufoiudh" {
                    cell.messageText.text = message.messageBody
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherUserMessageCell.reuseIdentifier, for: indexPath) as! OtherUserMessageCell
                if message.messageBody != "oqiudfboasiudf" {
                    cell.messageText.text = message.messageBody
                }
                return cell
            }
        case .notification:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: indexPath)
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationDetailsTableViewCell.reuseIdentifier, for: indexPath)
            return cell
        }
    }
}


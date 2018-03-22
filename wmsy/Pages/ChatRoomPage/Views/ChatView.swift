//
//  ChatView.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ChatView: UIView {
    static let hostCell = "HostCell"
    static let guestCell = "GuestCell"
    static let notifCell = "NotificationCell"
    static let locCell = "LocationCell"
    
    
    public var chatTableView = UITableView()
    public var textInput = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupChatTableView()
        setupTextInput()
    }
    private func setupChatTableView() {
        chatTableView.register(HostMessageTableViewCell.self, forCellReuseIdentifier: ChatView.hostCell)
        chatTableView.register(GuestMessageTableViewCell.self, forCellReuseIdentifier: ChatView.guestCell)
        chatTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: ChatView.notifCell)
        chatTableView.register(LocationDetailsTableViewCell.self, forCellReuseIdentifier: ChatView.locCell)
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        
        addSubview(chatTableView)
        chatTableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
        }
    }
    private func setupTextInput() {
        addSubview(textInput)
        textInput.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.top.equalTo(chatTableView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    
}

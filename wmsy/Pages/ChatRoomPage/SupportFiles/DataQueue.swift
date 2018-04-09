//
//  DataQueue.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class Node<T> {
    var key: T
    var next: Node<T>?
    init(key: T) {
        self.key = key
    }
}

struct Queue<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    var isEmpty: Bool {
        return head == nil
    }
    mutating func enQueue(_ newElement: T) {
        let newNode = Node(key: newElement)
        guard let tail = tail else {
            self.head = newNode
            self.tail = newNode
            return
        }
        tail.next = newNode
        self.tail = newNode
    }
    mutating func deQueue() -> T? {
        guard let oldHead = head else {
            return nil
        }
        self.head = oldHead.next
        if oldHead.next == nil {
            self.tail = nil
        }
        return oldHead.key
    }
    func peek() -> T? {
        return self.head?.key
    }
}

protocol DataReceiver: class {
    func accept(message: Message?) -> Void
}

class DataQueue {
    private init(){
    }
    static let manager = DataQueue()
    
    private var messageQueue = Queue<Message>()
    public weak var delegate: DataReceiver?
    private var messageTimer: Timer!
    
    public func startSendingData() {
        messageTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(sendNextMessage), userInfo: nil, repeats: true)
    }
    @objc private func sendNextMessage() {
        delegate?.accept(message: messageQueue.deQueue())
        if messageQueue.isEmpty { messageTimer.invalidate() }
    }
    
    public func configure() {
        setupObservers()
        
        
    }
    private func setupObservers() {
        // get current user as local struct AppUser instance
        
        // get all interests from current user
        // attach listeners to changes in interests
        
        // get all whims hosted by current user
        
        
        let gettingInterestsComplete: () -> () = {
        }
        let gettingUserComplete: () -> () = {
            var interests = [Interest]()
//            DBService.manager.getAllInterests(forUser: AppUser.currentAppUser!) { (dbInterests) in
//                interests = dbInterests
//                gettingInterestsComplete()
//            }
        }
        
        // setup currentAppUser
        DBService.manager.getAppUser(fromID: AuthUserService.manager.getCurrentUser()!.uid) { (appUser) in
            AppUser.currentAppUser = appUser
            gettingUserComplete()
        }
        
        
        // TODO: listen for interests change
        
        // TODO: listen for messages change
        
        
//        let query = DBService.manager.messagesRef.que
//        let currentUser =
    }
    
}

// MARK: - messages queue (for notifications)
extension DataQueue {
    
    
    
}






//
//  MenuData.swift
//  wmsy
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

protocol MenuDataDelegate: class {
    
}

class MenuData {
    private init() {
        // TODO: setup listeners here
    }
    static let manager = MenuData()
    
    public weak var delegate: MenuDataDelegate?
    
    private var currentPage = 0
    private var hostedChats = [Message]()
    private var interestedChats = [Message]()
    private var pendingInterests = [Interest]()
    
    
}

//
//  AuthUserService.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    
    /// The singleton object associated with the AuthUserService API client.
    static let manager = AuthUserService()
    private var auth: Auth!
//    weak public var delegate: AuthUserServiceDelegate?
    
    
    
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
    
    
}

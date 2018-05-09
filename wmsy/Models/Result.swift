//
//  Result.swift
//  wmsy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(value: T)
    case failure(error: U)
}

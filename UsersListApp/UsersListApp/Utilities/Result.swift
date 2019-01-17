//
//  Result.swift
//  UsersListApp
//
//  Created by Fedya on 1/16/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    // MARK: Constructors
    public init(value: Value) {
        self = .success(value)
    }
    
    public init(error: Error) {
        self = .failure(error)
    }
    
    // MARK: Shorthands
    var value: Value? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}

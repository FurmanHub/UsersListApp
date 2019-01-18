//
//  User.swift
//  UsersListApp
//
//  Created by Fedya on 1/16/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation

final class User: Decodable {
    let name: UserName
    let avatar: UserAvatar
    let phoneNumber: String
    let email: String
    
    init(name: UserName, avatar: UserAvatar, phoneNumber: String, email: String) {
        self.name = name
        self.avatar = avatar
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    struct UserName: Decodable {
        var first: String
        var last: String
    }
    struct UserAvatar: Decodable {
        var medium: URL
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case avatar = "picture"
        case phoneNumber = "phone"
        case email = "email"
    }
}

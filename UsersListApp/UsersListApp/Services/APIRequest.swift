//
//  APIRequest.swift
//  UsersListApp
//
//  Created by Fedya on 1/16/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseType: Decodable
    var parameters: [String: String] { get }
    var baseURLPath: String { get }
}

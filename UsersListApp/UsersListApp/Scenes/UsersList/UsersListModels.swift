//
//  UsersListModels.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

enum UsersList {    
    enum FetchUsers {
        struct Request: APIRequest {
            typealias ResponseType = Response.UserResponse
            var baseURLPath: String {
                return "https://randomuser.me/api/"
            }
            var resultCount: Int
            var page: Int
            
            var parameters: [String : String] {
                return [
                    "page": page.description,
                    "results" : resultCount.description
                ]
            }
        }
        struct Response {
            struct UserResponse: Decodable {
                var results: [User]
                var info: MetaResponse
                
                struct MetaResponse: Decodable {
                    var page: Int
                }
            }
        }
        struct ViewModel {
            struct DisplayedUser {
                var firstName: String
                var lastName: String
                var avatarUrl: URL
                var phoneNumber: String
            }
            var displayedUsers: [DisplayedUser]
        }
    }
}

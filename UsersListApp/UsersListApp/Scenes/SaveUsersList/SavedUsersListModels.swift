//
//  SavedUsersListModels.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

enum SavedUsersList {
    enum fetchSavedUsers {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
            struct DisplayedUser {
                var firstName: String
                var lastName: String
                var avatarUrl: URL
                var phoneNumber: String
                var id: String
            }
            var displayedUsers: [DisplayedUser]
        }
    }
}

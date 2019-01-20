//
//  SavedUsersListWorker.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

final class SavedUsersListWorker {
    private let usersStorage = UsersStorage(coreData: CoreDataContainer())
    
    func fetchUsers() -> [User] {
        return usersStorage.fetchUsers()
    }
}

//
//  SavedUsersListInteractor.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListBusinessLogic {
    func fetchUsersFromLocalDB()
    func removeUserFormLocalDB(by id: String)
}

final class SavedUsersListInteractor: SavedUsersListBusinessLogic {
    var presenter: SavedUsersListPresentationLogic?
    private let worker = SavedUsersListWorker()
    
    // MARK: Do something
    
    func fetchUsersFromLocalDB() {
        let fetchedUsers = worker.fetchUsers()
        presenter?.presentSavedUsers(users: fetchedUsers)
    }
    
    func removeUserFormLocalDB(by id: String) {
        worker.removeUser(by: id)
    }
}

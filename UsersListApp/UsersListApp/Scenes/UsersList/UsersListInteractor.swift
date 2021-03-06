//
//  UsersListInteractor.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol UsersListBusinessLogic {
    func fetchUsers(request: UsersList.FetchUsers.Request)
    var requestPage: Int? { get set }
}

protocol UsersListDataStore {
    var users: [User]? { get }
}

final class UsersListInteractor: UsersListBusinessLogic, UsersListDataStore {
    var requestPage: Int?
    var users: [User]?
    
    var presenter: UsersListPresentationLogic?
    private var worker = UsersListWorker()
    private var isLoading = false
    
    // MARK: Fetch users
    
    func fetchUsers(request: UsersList.FetchUsers.Request) {
        guard isLoading == false else { return }
        isLoading = true
        worker.executeRequest(request: request) { [weak self] (result: Result<UsersList.FetchUsers.Response.UserResponse>) in
            guard let `self` = self else { return }
            self.isLoading = false
            if let fetchResponse = result.value {
                self.presenter?.presentFetchedUsers(response: fetchResponse)
                self.users = fetchResponse.results
                self.requestPage = fetchResponse.info.page
                do {
                    try self.worker.saveUsers(users: fetchResponse.results)
                } catch {
                    print("Error with saving in UsersListInteractor")
                }
            } else {
                print(result.error?.localizedDescription ?? "Unexpected error")
            }
        }
    }
}

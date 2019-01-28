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
        worker.executeRequest(request: request)
            .done { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                self.presenter?.presentFetchedUsers(response: result)
                self.users = result.results
                self.requestPage = result.info.page
                try self.worker.saveUsers(users: result.results)
            }
            .catch { [weak self] error in
                guard let self = self else { return }
                self.handleErrors(error: error)
        }
    }
    
    func handleErrors(error: Error) {
        if let error = error as? UsersStorageErrors {
            switch error {
            case .invalidSave:
                print("Invalid save")
            default:
                print("Unexpected error")
            }
        }
        if let error = error as? APIError {
            switch error {
            case .badRequest:
                print("Bad request")
            case .invalidResponse:
                print("Invalid response")
            }
        }
    }
}

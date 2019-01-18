//
//  SavedUsersListInteractor.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListBusinessLogic {
    func doSomething(request: SavedUsersList.Something.Request)
}

protocol SavedUsersListDataStore {
    
}

final class SavedUsersListInteractor: SavedUsersListBusinessLogic, SavedUsersListDataStore {
    var presenter: SavedUsersListPresentationLogic?
    var worker: SavedUsersListWorker?
    
    // MARK: Do something
    
    func doSomething(request: SavedUsersList.Something.Request) {
        worker = SavedUsersListWorker()
        worker?.doSomeWork()
        
        let response = SavedUsersList.Something.Response()
        presenter?.presentSomething(response: response)
    }
}

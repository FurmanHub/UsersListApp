//
//  UsersListInteractor.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol UsersListBusinessLogic {
    func doSomething(request: UsersList.Something.Request)
}

protocol UsersListDataStore {
    //var name: String { get set }
}

class UsersListInteractor: UsersListBusinessLogic, UsersListDataStore {
    var presenter: UsersListPresentationLogic?
    var worker: UsersListWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: UsersList.Something.Request) {
        worker = UsersListWorker()
        worker?.doSomeWork()
        
        let response = UsersList.Something.Response()
        presenter?.presentSomething(response: response)
    }
}

//
//  UsersListPresenter.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//


import UIKit

protocol UsersListPresentationLogic {
    func presentSomething(response: UsersList.Something.Response)
}

class UsersListPresenter: UsersListPresentationLogic {
    weak var viewController: UsersListDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: UsersList.Something.Response) {
        let viewModel = UsersList.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

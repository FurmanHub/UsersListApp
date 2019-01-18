//
//  SavedUsersListPresenter.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListPresentationLogic {
    func presentSomething(response: SavedUsersList.Something.Response)
}

final class SavedUsersListPresenter: SavedUsersListPresentationLogic {
    weak var viewController: SavedUsersListDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: SavedUsersList.Something.Response) {
        let viewModel = SavedUsersList.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}

//
//  SavedUsersListPresenter.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListPresentationLogic {
    func presentSavedUsers(users: [User])
}

final class SavedUsersListPresenter: SavedUsersListPresentationLogic {
    weak var viewController: SavedUsersListDisplayLogic?
    
    // MARK: Present saved users
    
    func presentSavedUsers(users: [User]) {
        var displayedUsers: [SavedUsersList.fetchSavedUsers.ViewModel.DisplayedUser] = []
        for user in users {
            let displayedUser = SavedUsersList.fetchSavedUsers.ViewModel.DisplayedUser(firstName: user.name.first, lastName: user.name.last, avatarUrl: user.avatar.medium, phoneNumber: user.phoneNumber, id: user.userID.uuid, email: user.email)
            displayedUsers.append(displayedUser)
        }
        let viewModel = SavedUsersList.fetchSavedUsers.ViewModel(displayedUsers: displayedUsers)
        viewController?.displaySavedUsers(viewModel: viewModel)
    }
}

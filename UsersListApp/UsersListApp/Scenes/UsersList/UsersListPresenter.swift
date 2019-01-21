//
//  UsersListPresenter.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//


import UIKit

protocol UsersListPresentationLogic {
    func presentFetchedUsers(response: UsersList.FetchUsers.Response.UserResponse)
}

final class UsersListPresenter: UsersListPresentationLogic {
    weak var viewController: UsersListDisplayLogic?
    
    // MARK: Present users
    
    func presentFetchedUsers(response: UsersList.FetchUsers.Response.UserResponse) {
        var displayedUsers: [UsersList.FetchUsers.ViewModel.DisplayedUser] = []
        for user in response.results {
            let displayedUser = UsersList.FetchUsers.ViewModel.DisplayedUser(firstName: user.name.first, lastName: user.name.last, avatarUrl: user.avatar.medium, phoneNumber: user.phoneNumber, id: user.userID.uuid, email: user.email)
            displayedUsers.append(displayedUser)
        }
        let viewModel = UsersList.FetchUsers.ViewModel(displayedUsers: displayedUsers)
        viewController?.displayFetchedUsers(viewModel: viewModel)
    }
}

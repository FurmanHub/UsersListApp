//
//  SavedUsersListRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol SavedUsersListRoutingLogic {
    func routeToEditProfile(user: User)
}

final class SavedUsersListRouter: NSObject, SavedUsersListRoutingLogic {
    weak var viewController: SavedUsersListViewController?
    
    func navigateToEditUserProfile(source: SavedUsersListViewController, destination: EditUserProfileViewController) {
        source.show(destination, sender: nil)
    }
    
    func routeToEditProfile(user: User) {
        let editUserProfileViewController = EditUserProfileViewController()
        var destinationDS = editUserProfileViewController.router?.dataStore
        passDataToEditProfileDataStore(user: user, destination: &destinationDS!)
        navigateToEditUserProfile(source: viewController!, destination: editUserProfileViewController)
    }
    
    //     MARK: Passing data
    
    func passDataToEditProfileDataStore(user: User, destination: inout EditUserProfileDataStore) {
        destination.user = user
    }
}

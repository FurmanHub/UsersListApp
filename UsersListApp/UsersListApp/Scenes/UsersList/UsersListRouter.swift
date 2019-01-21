//
//  UsersListRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol UsersListRoutingLogic {
    func routeToEditProfile(user: User)
}

final class UsersListRouter: NSObject, UsersListRoutingLogic {
    weak var viewController: UsersListViewController?
    
//     MARK: Navigation
    
    func navigateToEditUserProfile(source: UsersListViewController, destination: EditUserProfileViewController) {
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

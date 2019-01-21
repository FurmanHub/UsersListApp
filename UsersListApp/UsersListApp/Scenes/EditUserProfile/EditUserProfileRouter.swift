//
//  EditUserProfileRouter.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol EditUserProfileDataPassing {
    var dataStore: EditUserProfileDataStore? { get }
}

final class EditUserProfileRouter: NSObject, EditUserProfileDataPassing {
    weak var viewController: EditUserProfileViewController?
    var dataStore: EditUserProfileDataStore?
}

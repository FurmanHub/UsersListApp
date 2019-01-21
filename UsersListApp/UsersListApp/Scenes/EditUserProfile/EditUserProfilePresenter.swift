//
//  EditUserProfilePresenter.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol EditUserProfilePresentationLogic {
    func presentSomething(response: EditUserProfile.Something.Response)
}

final class EditUserProfilePresenter: EditUserProfilePresentationLogic {
    weak var viewController: EditUserProfileDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: EditUserProfile.Something.Response) {
        let viewModel = EditUserProfile.Something.ViewModel()
//        viewController?.displaySomething(viewModel: viewModel)
    }
}

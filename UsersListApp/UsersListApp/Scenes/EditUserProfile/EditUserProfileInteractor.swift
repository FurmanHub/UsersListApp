//
//  EditUserProfileInteractor.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

protocol EditUserProfileBusinessLogic {
    func updateUserInLocalDB(user: User) throws
}

protocol EditUserProfileDataStore {
    var user: User? { get set }
}

class EditUserProfileInteractor: EditUserProfileBusinessLogic, EditUserProfileDataStore {
    var user: User?
    var presenter: EditUserProfilePresentationLogic?
    var worker: EditUserProfileWorker?
    
    
    // MARK: update user
    

    
    func updateUserInLocalDB(user: User) throws {
        worker = EditUserProfileWorker()
        do {
            try worker?.updateUser(user: user)
        } catch {
            print("Cannot update user")
            throw NSError(domain: "", code: 1, userInfo: [:])
        }
    }
}

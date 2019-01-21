//
//  EditUserProfileWorker.swift
//  UsersListApp
//
//  Created by Fedya on 1/20/19.
//  Copyright (c) 2019 Fedya. All rights reserved.
//

import UIKit

enum ValidateUserError: Error {
    case invalidFirstName
    case invalidLastName
    case invalidEmail
}

final class EditUserProfileWorker {
    private let usersStorage = UsersStorage(coreData: CoreDataContainer())
    
    // General Email Regex (RFC 5322 Official Standard)
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    private func validateData(user: User) -> Bool {
        let firstName = user.name.first
        let lastName = user.name.last
        guard firstName.count > 0 && firstName.count < 31 else {
            return false
        }
        guard lastName.count > 0 && lastName.count < 31 else {
            return false
        }
        guard validateEmail(candidate: user.email) else {
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: firstName, options: [], range: NSMakeRange(0, firstName.count)) != nil {
                return false
            }
            if regex.firstMatch(in: lastName, options: [], range: NSMakeRange(0, lastName.count)) != nil {
                return false
            }
        } catch {
            print("Some error while validation")
        }
        return true
    }
    
    // Have no time to improve error handling(
    func updateUser(user: User) throws {
        guard validateData(user: user) == true else {
            throw NSError(domain: "", code: 2, userInfo: [:])
        }
        do {
            try usersStorage.updateUser(user: user)
        } catch {
        }
    }
}

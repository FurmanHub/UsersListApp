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
    
    private func validateData(user: User) throws -> Bool {
        let firstName = user.name.first
        let lastName = user.name.last
        guard firstName.count > 0 && firstName.count < 31 else {
            throw ValidateUserError.invalidFirstName
        }
        guard lastName.count > 0 && lastName.count < 31 else {
            throw ValidateUserError.invalidLastName
        }
        guard validateEmail(candidate: user.email) else {
            throw ValidateUserError.invalidEmail
        }
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: [])
            if regex.firstMatch(in: firstName, options: [], range: NSMakeRange(0, firstName.count)) != nil {
                throw ValidateUserError.invalidFirstName
            }
            if regex.firstMatch(in: lastName, options: [], range: NSMakeRange(0, lastName.count)) != nil {
                throw ValidateUserError.invalidLastName
            }
        } catch {
            print("Some error while validation")
        }
        return true
    }
    
    func updateUser(user: User) throws {
        do {
            guard try validateData(user: user) else { return }
            try usersStorage.updateUser(user: user)
        } catch ValidateUserError.invalidFirstName {
            print("Invalid first name")
            throw ValidateUserError.invalidFirstName
        } catch ValidateUserError.invalidLastName {
            print("Invalid last name")
            throw ValidateUserError.invalidLastName
        } catch ValidateUserError.invalidEmail {
            print("Invalid email")
            throw ValidateUserError.invalidEmail
        }
    }
}

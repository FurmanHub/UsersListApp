//
//  UsersStorage.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum UsersStorageErrors: Error {
    case invalidSave
}

final class UsersStorage {
    private var coreData: CoreDataContainer
    private var context: NSManagedObjectContext {
        return coreData.persistentContainer.viewContext
    }
    private var entityName: String {
        return "User"
    }
    
    private var entity: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    init(coreData: CoreDataContainer) {
        self.coreData = coreData
    }
    
    func saveUser(firstName: String, lastName: String, avatarUrl: String, email: String, phone: String) throws {
        guard let newUser = NSManagedObject(entity: entity, insertInto: context) as? UserMO else {
            return
        }
        newUser.setValue(firstName, forKey: "firstName")
        newUser.setValue(lastName, forKey: "lastName")
        newUser.setValue(avatarUrl, forKey: "avatarUrl")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(phone, forKey: "phoneNumber")
        do {
            try context.save()
        } catch {
            print("Failed saving to local DB")
            throw UsersStorageErrors.invalidSave
        }
    }
    
    func saveUsers(users: [User]) throws {
        for user in users {
            let firstName = user.name.first
            let lastName = user.name.last
            let avatarUrl = user.avatar.medium
            let email = user.email
            let phoneNumber = user.phoneNumber
            try saveUser(firstName: firstName, lastName: lastName, avatarUrl: avatarUrl.absoluteString, email: email, phone: phoneNumber)
        }
    }
    
    func fetchUsers() -> [User] {
        var users = [User]()
        let request = UserMO.userMOfetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for user in result {
                if let firstName = user.firstName, let lastName = user.lastName, let avatarUrl = user.avatarUrl, let phoneNumber = user.phoneNumber, let email = user.email {
                    let userName = User.UserName.init(first: firstName, last: lastName)
                    let userAvatar = User.UserAvatar.init(medium: URL(string: avatarUrl)!)
                    users.append(User(name: userName, avatar: userAvatar, phoneNumber: phoneNumber, email: email))
                }
            }
        } catch {
            print("Failed fetch from local DB")
        }
        return users
    }
    
    func removeUsers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed remove users from local DB")
        }
    }
}

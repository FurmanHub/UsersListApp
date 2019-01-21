//
//  CoreDataContainer.swift
//  UsersListApp
//
//  Created by Fedya on 1/18/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataContainer {
    private(set) var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

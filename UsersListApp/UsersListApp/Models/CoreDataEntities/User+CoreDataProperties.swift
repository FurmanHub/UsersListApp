//
//  User+CoreDataProperties.swift
//  
//
//  Created by Fedya on 1/18/19.
//
//

import Foundation
import CoreData


extension UserMO {
    
    @nonobjc public class func userMOfetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var id: String?

}

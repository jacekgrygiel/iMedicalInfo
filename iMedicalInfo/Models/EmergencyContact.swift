//
//  EmergencyContact.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import Foundation
import CoreData

@objc (EmergencyContact)
class EmergencyContact: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var relationship: String
    @NSManaged var phones: AnyObject

}

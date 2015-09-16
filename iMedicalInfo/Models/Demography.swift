//
//  Demography.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import Foundation
import CoreData

@objc (Demography)
class Demography: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var birthdate: NSDate
    @NSManaged var phones: AnyObject
    @NSManaged var email: String
    @NSManaged var faxNumber: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var patient: Patient

}

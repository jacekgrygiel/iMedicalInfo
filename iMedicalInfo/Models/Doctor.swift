//
//  Doctor.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import Foundation
import CoreData

@objc (Doctor)
class Doctor: NSManagedObject {

    @NSManaged var businessCard: NSData
    @NSManaged var specialists: AnyObject
    @NSManaged var fullName: String
    @NSManaged var isActive: NSNumber
    @NSManaged var photo: NSData
    @NSManaged var patients: NSSet

}

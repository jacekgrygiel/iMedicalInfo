//
//  Patient.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import Foundation
import CoreData

@objc (Patient)
class Patient: NSManagedObject {

    @NSManaged var uuid: String
    @NSManaged var patientName: String
    @NSManaged var photo: NSData
    @NSManaged var demography: Demography
    @NSManaged var healthCards: NSSet
    @NSManaged var emergencyContacts: EmergencyContact
    @NSManaged var doctors: NSSet

}



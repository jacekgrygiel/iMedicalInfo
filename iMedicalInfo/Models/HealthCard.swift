//
//  HealthCard.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import Foundation
import CoreData

@objc (HealthCard)
class HealthCard: NSManagedObject {

    @NSManaged var healthInsurance: NSData
    @NSManaged var medicationInsurance: NSData
    @NSManaged var paymentCard: NSData
    @NSManaged var patient: Patient

}

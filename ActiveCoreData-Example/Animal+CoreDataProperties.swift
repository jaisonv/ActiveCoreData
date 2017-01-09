//
//  Animal+CoreDataProperties.swift
//  ActiveCoreData-Example
//
//  Created by Jaison Vieira on 8/23/16.
//  Copyright © 2016 jaisonv. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Animal {

    @NSManaged var breed: String?
    @NSManaged var name: String?
    @NSManaged var species: String?
    @NSManaged var color: String?
    @NSManaged var gender: NSNumber?

}

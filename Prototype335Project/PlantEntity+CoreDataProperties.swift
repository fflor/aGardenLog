//
//  PlantEntity+CoreDataProperties.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import Foundation
import CoreData


extension PlantEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlantEntity> {
        return NSFetchRequest<PlantEntity>(entityName: "PlantEntity");
    }

    @NSManaged public var plantName: String?
    @NSManaged public var details: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var logEntry: NSSet?

}

// MARK: Generated accessors for logEntry
extension PlantEntity {

    @objc(addLogEntryObject:)
    @NSManaged public func addToLogEntry(_ value: LogEntity)

    @objc(removeLogEntryObject:)
    @NSManaged public func removeFromLogEntry(_ value: LogEntity)

    @objc(addLogEntry:)
    @NSManaged public func addToLogEntry(_ values: NSSet)

    @objc(removeLogEntry:)
    @NSManaged public func removeFromLogEntry(_ values: NSSet)

}

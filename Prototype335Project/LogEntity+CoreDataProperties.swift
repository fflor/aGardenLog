//
//  LogEntity+CoreDataProperties.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import Foundation
import CoreData


extension LogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LogEntity> {
        return NSFetchRequest<LogEntity>(entityName: "LogEntity");
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var entry: String?
    @NSManaged public var plant: PlantEntity?

}

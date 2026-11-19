//
//  Pool4_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool4_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool4_CoreData> {
        return NSFetchRequest<Pool4_CoreData>(entityName: "Pool4_CoreData")
    }

    @NSManaged public var backwashImage: Data?
    @NSManaged public var backWashOption: String?
    @NSManaged public var catchBasinImage: Data?
    @NSManaged public var catchBasinOption: String?
    @NSManaged public var equipAreaData: String?
    @NSManaged public var equipAreaImage: Data?
    @NSManaged public var equipAreaOption: String?
    @NSManaged public var report_id: String?
    @NSManaged public var slotDrainImage: Data?
    @NSManaged public var slotDrainOption: String?
    @NSManaged public var solarSystemImage: Data?
    @NSManaged public var solarSystemOption: String?
    @NSManaged public var waterFeatureImage: Data?
    @NSManaged public var waterFeatureOption: String?
    @NSManaged public var pool4_CoreData: Pool1_CoreData?

}

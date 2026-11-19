//
//  Pool3_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool3_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool3_CoreData> {
        return NSFetchRequest<Pool3_CoreData>(entityName: "Pool3_CoreData")
    }

    @NSManaged public var isFloorSystem: String?
    @NSManaged public var isPoolCleaning: String?
    @NSManaged public var isPoolWaterFeature: String?
    @NSManaged public var isRecentWorkAroundPool: String?
    @NSManaged public var isSolarSystem: String?
    @NSManaged public var isWaterVisible: String?
    @NSManaged public var poolSurfaceOption: String?
    @NSManaged public var poolWaterFeatureOption: String?
    @NSManaged public var pumpRunningInfo: String?
    @NSManaged public var pumpRunningOption: String?
    @NSManaged public var report_id: String?
    @NSManaged public var pool3_CoreData: Pool1_CoreData?

}

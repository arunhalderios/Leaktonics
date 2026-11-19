//
//  Pool6_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool6_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool6_CoreData> {
        return NSFetchRequest<Pool6_CoreData>(entityName: "Pool6_CoreData")
    }

    @NSManaged public var isEstimateToFollow: String?
    @NSManaged public var isLocationMarked: String?
    @NSManaged public var leaksNoted: String?
    @NSManaged public var markLocationDescribe: String?
    @NSManaged public var report_id: String?
    @NSManaged public var suctionAir: String?
    @NSManaged public var suctionLineAirOption: String?
    @NSManaged public var summaryNote: String?
    @NSManaged public var surgeTank: String?
    @NSManaged public var pool6_CoreData: Pool1_CoreData?

}

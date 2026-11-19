//
//  Plumber3_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 17/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Plumber3_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plumber3_CoreData> {
        return NSFetchRequest<Plumber3_CoreData>(entityName: "Plumber3_CoreData")
    }

    @NSManaged public var completeImg: Data?
    @NSManaged public var completeLeakDetectionText: String?
    @NSManaged public var enteringBuildingImg: Data?
    @NSManaged public var interiorSummaryText: String?
    @NSManaged public var leakHeaderStubsText: String?
    @NSManaged public var leakHeardatTouchStubOption: String?
    @NSManaged public var leakHeardImg: Data?
    @NSManaged public var leakHeardStubOption: String?
    @NSManaged public var leakHeardTouchImg: Data?
    @NSManaged public var leakHeardTouchStubText: String?
    @NSManaged public var mainBuildingEntranceOption: String?
    @NSManaged public var mainBuildingEntranceText: String?
    @NSManaged public var meterShutdownOption: String?
    @NSManaged public var monitorFiveMinuteOption: String?
    @NSManaged public var otherStructureMeterOption: String?
    @NSManaged public var pressureTestedForLeakOption: String?
    @NSManaged public var pressureTestedImg: Data?
    @NSManaged public var pressureTestedText: String?
    @NSManaged public var report_id: String?
    @NSManaged public var shutdownBuildingFromMeterOption: String?
    @NSManaged public var shutdownHotWaterToBuildingOption: String?
    @NSManaged public var visualWalkedImg: Data?
    @NSManaged public var visualWalkOutsideOption: String?
    @NSManaged public var visualWalkOutsideText: String?
    @NSManaged public var walkedInsideImg: Data?
    @NSManaged public var walkedInsideParameterOption: String?
    @NSManaged public var walkedInsideParameterText: String?

}

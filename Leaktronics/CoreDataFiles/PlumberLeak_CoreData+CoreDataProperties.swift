//
//  PlumberLeak_CoreData+CoreDataProperties.swift
//  
//
//  Created by ivaninfotech on 6/11/20.
//
//

import Foundation
import CoreData


extension PlumberLeak_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlumberLeak_CoreData> {
        return NSFetchRequest<PlumberLeak_CoreData>(entityName: "PlumberLeak_CoreData")
    }

    @NSManaged public var addressPlumber: String?
    @NSManaged public var cityPlumber: String?
    @NSManaged public var completeImg: Data?
    @NSManaged public var completeLeakDetectionText: String?
    @NSManaged public var emailPlumber: String?
    @NSManaged public var enteringBuildingImg: Data?
    @NSManaged public var findUsOptionPlumber: String?
    @NSManaged public var fireSuppressionOption: String?
    @NSManaged public var floorHeating: String?
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
    @NSManaged public var namePlumberLeak: String?
    @NSManaged public var notesPlumber: String?
    @NSManaged public var numberOfBuilding: String?
    @NSManaged public var otherNotesPlumber: String?
    @NSManaged public var otherStructureMeterOption: String?
    @NSManaged public var phoneNoPlumber: String?
    @NSManaged public var plumberCallReasonText: String?
    @NSManaged public var plumberFindUsText: String?
    @NSManaged public var plumberfireSuppressionText: String?
    @NSManaged public var plumberPropertyText: String?
    @NSManaged public var plumberResidentText: String?
    @NSManaged public var plumberStoriesText: String?
    @NSManaged public var plumberSwimmingText: String?
    @NSManaged public var pressureTestedForLeakOption: String?
    @NSManaged public var pressureTestedImg: Data?
    @NSManaged public var pressureTestedText: String?
    @NSManaged public var priceForLeakPlumber: String?
    @NSManaged public var propertyImgs: Data?
    @NSManaged public var propertyTypePlumber: String?
    @NSManaged public var reasonForCallPlumber: String?
    @NSManaged public var residentialOption: String?
    @NSManaged public var shutdownBuildingFromMeterOption: String?
    @NSManaged public var shutdownHotWaterToBuildingOption: String?
    @NSManaged public var statePlumber: String?
    @NSManaged public var storiesTypePlumber: String?
    @NSManaged public var swimmingOption: String?
    @NSManaged public var visualWalkedImg: Data?
    @NSManaged public var visualWalkOutsideOption: String?
    @NSManaged public var visualWalkOutsideText: String?
    @NSManaged public var walkedInsideImg: Data?
    @NSManaged public var walkedInsideParameterOption: String?
    @NSManaged public var walkedInsideParameterText: String?
    @NSManaged public var zipPlumber: String?
    @NSManaged public var plumber_inspection_date_time: String?
    @NSManaged public var isPlumberType: String?
    

}

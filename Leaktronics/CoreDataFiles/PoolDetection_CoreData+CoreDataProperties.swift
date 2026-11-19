//
//  PoolDetection_CoreData+CoreDataProperties.swift
//  
//
//  Created by ivaninfotech on 6/11/20.
//
//

import Foundation
import CoreData


extension PoolDetection_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PoolDetection_CoreData> {
        return NSFetchRequest<PoolDetection_CoreData>(entityName: "PoolDetection_CoreData")
    }

    @NSManaged public var addressPool: String?
    @NSManaged public var approxDimentionDescription: String?
    @NSManaged public var approxDimentionText: String?
    @NSManaged public var autofillEQ: String?
    @NSManaged public var backwashImage: Data?
    @NSManaged public var backWashOption: String?
    @NSManaged public var catchBasinImage: Data?
    @NSManaged public var catchBasinOption: String?
    @NSManaged public var cityPool: String?
    @NSManaged public var cleanerLines: String?
    @NSManaged public var emailPool: String?
    @NSManaged public var equipAreaData: String?
    @NSManaged public var equipAreaImage: Data?
    @NSManaged public var equipAreaOption: String?
    @NSManaged public var findUsOption: String?
    @NSManaged public var inpectTimePool: Date?
    @NSManaged public var isCommercialPool: String?
    @NSManaged public var isEstimateToFollow: String?
    @NSManaged public var isFloorSystem: String?
    @NSManaged public var isFountain: String?
    @NSManaged public var isLeaking: String?
    @NSManaged public var isLocationMarked: String?
    @NSManaged public var isPoolCleaning: String?
    @NSManaged public var isPoolWaterFeature: String?
    @NSManaged public var isRecentWorkAroundPool: String?
    @NSManaged public var isSolarSystem: String?
    @NSManaged public var isVinylLinearLeak: String?
    @NSManaged public var isWaterVisible: String?
    @NSManaged public var leaksNoted: String?
    @NSManaged public var markLocationDescribe: String?
    @NSManaged public var namePoolDetection: String?
    @NSManaged public var notesPool: String?
    @NSManaged public var otherFindUsText: String?
    @NSManaged public var otherNotesPool: String?
    @NSManaged public var phoneNoPool: String?
    @NSManaged public var poolSizeOption: String?
    @NSManaged public var poolSurfaceOption: String?
    @NSManaged public var poolWaterFeatureOption: String?
    @NSManaged public var priceForLeakPool: String?
    @NSManaged public var pumpRunningInfo: String?
    @NSManaged public var pumpRunningOption: String?
    @NSManaged public var reasonForCallOption: String?
    @NSManaged public var skimmerSuction: String?
    @NSManaged public var slotDrainImage: Data?
    @NSManaged public var slotDrainOption: String?
    @NSManaged public var solarSystemImage: Data?
    @NSManaged public var solarSystemOption: String?
    @NSManaged public var spaFill: String?
    @NSManaged public var spaJets: String?
    @NSManaged public var spaSizeOption: String?
    @NSManaged public var statePool: String?
    @NSManaged public var suction: String?
    @NSManaged public var suctionAir: String?
    @NSManaged public var suctionLineAirOption: String?
    @NSManaged public var summaryNote: String?
    @NSManaged public var surgeTank: String?
    @NSManaged public var waterFeatureImage: Data?
    @NSManaged public var waterFeatureOption: String?
    @NSManaged public var zipPool: String?
    @NSManaged public var pool_inspection_date_time: String?

}

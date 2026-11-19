//
//  Plumber2_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 17/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Plumber2_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plumber2_CoreData> {
        return NSFetchRequest<Plumber2_CoreData>(entityName: "Plumber2_CoreData")
    }

    @NSManaged public var findUsOptionPlumber: String?
    @NSManaged public var fireSuppressionOption: String?
    @NSManaged public var floorHeating: String?
    @NSManaged public var numberOfBuilding: String?
    @NSManaged public var plumberCallReasonText: String?
    @NSManaged public var plumberFindUsText: String?
    @NSManaged public var plumberfireSuppressionText: String?
    @NSManaged public var plumberPropertyText: String?
    @NSManaged public var plumberResidentText: String?
    @NSManaged public var plumberStoriesText: String?
    @NSManaged public var plumberSwimmingText: String?
    @NSManaged public var propertyImg: Data?
    @NSManaged public var propertyTypePlumber: String?
    @NSManaged public var reasonForCallPlumber: String?
    @NSManaged public var report_id: String?
    @NSManaged public var residentialOption: String?
    @NSManaged public var storiesTypePlumber: String?
    @NSManaged public var swimmingOption: String?

}

//
//  Pool2_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool2_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool2_CoreData> {
        return NSFetchRequest<Pool2_CoreData>(entityName: "Pool2_CoreData")
    }

    @NSManaged public var approxDimentionDescription: String?
    @NSManaged public var approxDimentionText: String?
    @NSManaged public var findUsOption: String?
    @NSManaged public var isCommercialPool: String?
    @NSManaged public var isFountain: String?
    @NSManaged public var otherFindUsText: String?
    @NSManaged public var poolSizeOption: String?
    @NSManaged public var reasonForCallOption: String?
    @NSManaged public var report_id: String?
    @NSManaged public var spaSizeOption: String?
    @NSManaged public var pool2_CoreData: Pool1_CoreData?

}

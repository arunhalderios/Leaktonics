//
//  Pool5_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool5_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool5_CoreData> {
        return NSFetchRequest<Pool5_CoreData>(entityName: "Pool5_CoreData")
    }

    @NSManaged public var autofillEQ: String?
    @NSManaged public var cleanerLines: String?
    @NSManaged public var isLeaking: String?
    @NSManaged public var isVinylLinearLeak: String?
    @NSManaged public var report_id: String?
    @NSManaged public var skimmerSuction: String?
    @NSManaged public var spaFill: String?
    @NSManaged public var spaJets: String?
    @NSManaged public var suction: String?
    @NSManaged public var pool5_CoreData: Pool1_CoreData?

}

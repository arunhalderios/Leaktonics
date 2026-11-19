//
//  Pool1_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 14/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Pool1_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pool1_CoreData> {
        return NSFetchRequest<Pool1_CoreData>(entityName: "Pool1_CoreData")
    }

    @NSManaged public var addressPool: String?
    @NSManaged public var cityPool: String?
    @NSManaged public var emailPool: String?
    @NSManaged public var namePoolDetection: String?
    @NSManaged public var notesPool: String?
    @NSManaged public var otherNotesPool: String?
    @NSManaged public var phoneNoPool: String?
    @NSManaged public var pool_inspection_date_time: String?
    @NSManaged public var priceForLeakPool: String?
    @NSManaged public var report_id: String?
    @NSManaged public var statePool: String?
    @NSManaged public var zipPool: String?
    @NSManaged public var pool2_CoreData: Pool2_CoreData?
    @NSManaged public var pool3_CoreData: Pool3_CoreData?
    @NSManaged public var pool4_CoreData: Pool4_CoreData?
    @NSManaged public var pool5_CoreData: Pool5_CoreData?
    @NSManaged public var pool6_CoreData: Pool6_CoreData?

}

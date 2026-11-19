//
//  Plumber1_CoreData+CoreDataProperties.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 17/07/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//
//

import Foundation
import CoreData


extension Plumber1_CoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plumber1_CoreData> {
        return NSFetchRequest<Plumber1_CoreData>(entityName: "Plumber1_CoreData")
    }

    @NSManaged public var addressPlumber: String?
    @NSManaged public var cityPlumber: String?
    @NSManaged public var emailPlumber: String?
    @NSManaged public var namePlumberLeak: String?
    @NSManaged public var notesPlumber: String?
    @NSManaged public var otherNotesPlumber: String?
    @NSManaged public var phoneNoPlumber: String?
    @NSManaged public var plumber_inspection_date_time: String?
    @NSManaged public var priceForLeakPlumber: String?
    @NSManaged public var report_id: String?
    @NSManaged public var statePlumber: String?
    @NSManaged public var zipPlumber: String?

}

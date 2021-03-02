//
//  Date_Info_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 3/1/21.
//
//

import Foundation
import CoreData

extension Date_Info_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Date_Info_Entity> {
        return NSFetchRequest<Date_Info_Entity>(entityName: "Date_Info_Entity")
    }

    @NSManaged public var start_date_attr: Date?
    @NSManaged public var end_date_attr: Date?
    @NSManaged public var date_info: Bg_Info_Entity?
    
    public var startDate: Date? {
        start_date_attr
    }
    
    public var endDate: Date? {
        end_date_attr
    }
    
    public var info: Bg_Info_Entity?? {
        date_info
    }
}

extension Date_Info_Entity : Identifiable {

}

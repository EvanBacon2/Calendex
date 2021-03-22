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

    @NSManaged public var year_attr: Int32
    @NSManaged public var month_attr: Int32
    @NSManaged public var day_attr: Int32
    @NSManaged public var entries_attr: Int32
    @NSManaged public var date_info: Bg_Info_Entity?
    
    public var year: Int {
        Int(year_attr)
    }
    
    public var month: Int {
        Int(month_attr)
    }
    
    public var day: Int {
        Int(day_attr)
    }
    
    public var entries: Int {
        Int(entries_attr)
    }
    
    public var info: Bg_Info_Entity? {
        date_info
    }
}

extension Date_Info_Entity : Identifiable {

}

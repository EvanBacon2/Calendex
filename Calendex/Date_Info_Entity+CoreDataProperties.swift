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
    @NSManaged public var date_info: Bg_Info_Entity?
    
    public var year: Int {
        get { return Int(year_attr) }
        set(year) { self.year_attr = Int32(year) }
    }
    
    public var month: Int {
        get { return Int(month_attr) }
        set(month) { self.month_attr = Int32(month) }
    }
    
    public var day: Int {
        get { return Int(day_attr) }
        set(day) { self.day_attr = Int32(day) }
    }
    
    public var info: Bg_Info_Entity? {
        date_info
    }
}

extension Date_Info_Entity : Identifiable {

}

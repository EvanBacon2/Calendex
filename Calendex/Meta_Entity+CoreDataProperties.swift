//
//  Meta_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import Foundation
import CoreData
import CoreGraphics

extension Meta_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meta_Entity> {
        return NSFetchRequest<Meta_Entity>(entityName: "Meta_Entity")
    }

    @NSManaged public var start_year_attr: Int32
    @NSManaged public var start_month_attr: Int32
    @NSManaged public var start_day_attr: Int32
    @NSManaged public var end_year_attr: Int32
    @NSManaged public var end_month_attr: Int32
    @NSManaged public var end_day_attr: Int32
    
    public var startYear: Int {
        get { return Int(start_year_attr) }
        set(year) { self.start_year_attr = Int32(year)}
    }
    
    public var startMonth: Int {
        get { return Int(start_month_attr) }
        set(month) { self.start_month_attr = Int32(month)}
    }
    
    public var startDay: Int {
        get { return Int(start_day_attr) }
        set(day) { self.start_day_attr = Int32(day)}
    }
    
    public var endYear: Int {
        get { return Int(end_year_attr) }
        set(year) { self.end_year_attr = Int32(year)}
    }
    
    public var endMonth: Int {
        get { return Int(end_month_attr) }
        set(month) { self.end_month_attr = Int32(month)}
    }
    
    public var endDay: Int {
        get { return Int(end_day_attr) }
        set(day) { self.end_day_attr = Int32(day)}
    }
}

extension Meta_Entity : Identifiable {

}

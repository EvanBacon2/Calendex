//
//  TimeInRange_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension TimeInRange_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeInRange_Entity> {
        return NSFetchRequest<TimeInRange_Entity>(entityName: "TimeInRange_Entity")
    }

    @NSManaged public var lowTime_attr: Float
    @NSManaged public var midTime_attr: Float
    @NSManaged public var highTime_attr: Float
    @NSManaged public var tir_info: Bg_Info_Entity?
    
    public var lowTime: CGFloat {
        get { return CGFloat(lowTime_attr) }
        set(lowTime) { self.lowTime_attr = Float(lowTime) }
    }
    
    public var midTime: CGFloat {
        get { return CGFloat(midTime_attr) }
        set(midTime) { self.midTime_attr = Float(midTime) }
    }
    
    public var highTime: CGFloat {
        get { return CGFloat(highTime_attr) }
        set(highTime) { self.highTime_attr = Float(highTime) }
    }
}

extension TimeInRange_Entity : Identifiable {

}

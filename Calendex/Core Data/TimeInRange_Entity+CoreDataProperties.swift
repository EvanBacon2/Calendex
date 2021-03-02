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
        CGFloat(lowTime_attr)
    }
    
    public var midTime: CGFloat {
        CGFloat(midTime_attr)
    }
    
    public var highTime: CGFloat {
        CGFloat(highTime_attr)
    }
}

extension TimeInRange_Entity : Identifiable {

}

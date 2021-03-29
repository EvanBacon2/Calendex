//
//  Measures_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension Measures_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measures_Entity> {
        return NSFetchRequest<Measures_Entity>(entityName: "Measures_Entity")
    }

    @NSManaged public var mean_attr: Float
    @NSManaged public var stdDeviation_attr: Float
    @NSManaged public var min_attr: Int32
    @NSManaged public var max_attr: Int32
    @NSManaged public var mea_info: Bg_Info_Entity?
    
    public var mean: CGFloat {
        get { return CGFloat(mean_attr) }
        set(mean) { self.mean_attr = Float(mean)}
    }
    
    public var stdDeviation: CGFloat {
        get { return CGFloat(stdDeviation_attr) }
        set(stdDev) { self.stdDeviation_attr = Float(stdDev) }
    }
    
    public var min: Int {
        get { return Int(min_attr) }
        set(min) { self.min_attr = Int32(min) }
    }

    public var max: Int {
        get { return Int(max_attr) }
        set(max) { self.max_attr = Int32(max) }
    }
}

extension Measures_Entity : Identifiable {

}

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
        CGFloat(mean_attr)
    }
    
    public var stdDeviation: CGFloat {
        CGFloat(stdDeviation_attr)
    }
    
    public var min: Int {
        Int(min_attr)
    }

    public var max: Int {
        Int(max_attr)
    }
}

extension Measures_Entity : Identifiable {

}

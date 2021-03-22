//
//  DistributionRange_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension DistributionRange_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DistributionRange_Entity> {
        return NSFetchRequest<DistributionRange_Entity>(entityName: "DistributionRange_Entity")
    }

    @NSManaged public var range_attr: Int32
    @NSManaged public var value_attr: Float
    @NSManaged public var disRange_dis: Distribution_Entity?
    
    public var range: CGFloat {
        CGFloat(range_attr)
    }
    
    public var value: CGFloat {
        CGFloat(value_attr)
    }
}

extension DistributionRange_Entity : Identifiable {

}

//
//  Distribution_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension Distribution_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Distribution_Entity> {
        return NSFetchRequest<Distribution_Entity>(entityName: "Distribution_Entity")
    }

    @NSManaged public var dis_info: Bg_Info_Entity?
    @NSManaged public var dis_disRange: NSSet?
    
    public var distribution: [DistributionRange_Entity] {
        let set = dis_disRange as? Set<DistributionRange_Entity> ?? []
        return set.sorted() { $0.value < $1.value }
    }
}

// MARK: Generated accessors for dis_disRange
extension Distribution_Entity {
    @objc(addDis_disRangeObject:)
    @NSManaged public func addToDis_disRange(_ value: DistributionRange_Entity)

    @objc(removeDis_disRangeObject:)
    @NSManaged public func removeFromDis_disRange(_ value: DistributionRange_Entity)

    @objc(addDis_disRange:)
    @NSManaged public func addToDis_disRange(_ values: NSSet)

    @objc(removeDis_disRange:)
    @NSManaged public func removeFromDis_disRange(_ values: NSSet)
}

extension Distribution_Entity : Identifiable {

}

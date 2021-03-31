//
//  Bg_Info_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension Bg_Info_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bg_Info_Entity> {
        return NSFetchRequest<Bg_Info_Entity>(entityName: "Bg_Info_Enitity")
    }

    @NSManaged public var entries_attr: Int32
    @NSManaged public var info_date: Date_Info_Entity?
    @NSManaged public var info_dis: Distribution_Entity?
    @NSManaged public var info_mea: Measures_Entity?
    
    public var entries: Int {
        get { return Int(entries_attr) }
        set(entries) { self.entries_attr = Int32(entries) }
    }
    
    public var distribution: [DistributionRange_Entity]? {
        info_dis?.distribution
    }
    
    public var measures: Measures_Entity? {
        info_mea
    }
}

extension Bg_Info_Entity : Identifiable {

}

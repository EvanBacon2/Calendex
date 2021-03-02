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

    @NSManaged public var info_date: Date_Info_Entity?
    @NSManaged public var info_tir: TimeInRange_Entity?
    @NSManaged public var info_dis: Distribution_Entity?
    @NSManaged public var info_mea: Measures_Entity?

    public var timeInRange: TimeInRange_Entity? {
        info_tir
    }
    
    public var distribution: [DistributionRange_Entity]? {
        info_dis?.distribution
    }
    
    public var meaures: Measures_Entity? {
        info_mea
    }
}

extension Bg_Info_Entity : Identifiable {

}

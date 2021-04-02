//
//  Token_Entity+CoreDataProperties.swift
//  Calendex
//
//  Created by Evan Bacon on 2/28/21.
//
//

import Foundation
import CoreData
import CoreGraphics

extension Token_Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Token_Entity> {
        return NSFetchRequest<Token_Entity>(entityName: "Token_Entity")
    }

    @NSManaged public var access_attr: String?
    @NSManaged public var expire_attr: Date
    @NSManaged public var refresh_attr: String?
    
    public var access: String? {
        get { return Date() < self.expire ? self.access_attr : nil }
        set(access) { self.access_attr = access}
    }
    
    public var expire: Date {
        get { return self.expire_attr }
        set(expire) { self.expire_attr = expire }
    }
    
    public var refresh: String? {
        get { return self.refresh_attr}
        set(refresh) { self.refresh_attr = refresh}
    }
}

extension Token_Entity : Identifiable {

}

//
//  Fetches.swift
//  Calendex
//
//  Created by Evan Bacon on 3/2/21.
//

import Foundation
import CoreData

struct Fetches {
    static func fetchDateInfo(year: Int = -1, month: Int = -1, day: Int = -1) -> NSFetchRequest<Date_Info_Entity> {
        let fetch = NSFetchRequest<Date_Info_Entity>(entityName: "Date_Info_Entity")
        fetch.sortDescriptors = []
        fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:
                         [NSPredicate(format: "year_attr == %@", NSNumber(value: year)),
                          NSPredicate(format: "month_attr == %@", NSNumber(value: month)),
                          NSPredicate(format: "day_attr == %@", NSNumber(value: day))])
        return fetch
    }
    
    static func fetchMonthsInYear(year: Int) -> NSFetchRequest<Date_Info_Entity> {
        let fetch = NSFetchRequest<Date_Info_Entity>(entityName: "Date_Info_Entity")
        fetch.sortDescriptors = [NSSortDescriptor(keyPath: \Date_Info_Entity.month_attr, ascending: true)]
        fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:
                         [NSPredicate(format: "year_attr == %@", NSNumber(value: year)),
                          NSPredicate(format: "month_attr != %@", -1),
                          NSPredicate(format: "day_attr == %@", -1)])
        return fetch
    }
    
    static func fetchDaysInMonth(year: Int, month: Int) -> NSFetchRequest<Date_Info_Entity> {
        let fetch = NSFetchRequest<Date_Info_Entity>(entityName: "Date_Info_Entity")
        fetch.sortDescriptors = [NSSortDescriptor(keyPath: \Date_Info_Entity.day_attr, ascending: true)]
        fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:
                         [NSPredicate(format: "year_attr == %@", NSNumber(value: year)),
                          NSPredicate(format: "month_attr == %@", NSNumber(value: month)),
                          NSPredicate(format: "day_attr != %@", -1)])
        return fetch
    }
}

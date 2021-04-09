//
//  DayViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import CoreData
import Foundation
import SwiftUI

class DayViewModel: ObservableObject {
    let coreContext = PersistenceController.shared.container.viewContext
    
    var metaData: Meta_Entity? = nil
    
    let year: Int
    let month: Int
    let day: Int
    
    let days: Int
    
    init(year: Int, month: Int, day: Int) {
        do {
            self.metaData = try coreContext.fetch(Fetches.fetchMetaData()).first
        } catch {
            print(error)
        }
        
        self.year = year
        self.month = month
        self.day = day
        
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        let date = cal.date(from: DateComponents(year: year, month: month))!
        self.days = cal.range(of: .day, in: .month, for: date)!.count
    }
    
    func startDay() -> Int {
        return self.year == metaData!.startYear && self.month == metaData!.startMonth ? metaData!.startDay : 1
    }
    
    func nDays() -> Int {
        if (self.year > metaData!.startYear ||
           (self.year == metaData!.startYear && self.month > metaData!.startMonth)) &&
           (self.year < metaData!.endYear ||
           (self.year == metaData!.endYear && self.month < metaData!.startMonth)) {
            return days
        } else if self.year == metaData!.startYear {
            return (days - metaData!.startDay) + 1
        } else {// if self.year == metaData.first!.endYear
            return metaData!.endDay
        }
    }
}

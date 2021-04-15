//
//  DayViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import CoreData
import Foundation
import SwiftUI

class DayViewModel: ObservableObject, DateShellViewModel {
    private let coreContext = PersistenceController.shared.container.viewContext
    
    private var metaData: Meta_Entity? = nil
    
    private let year: Int
    private let month: Int
    private let day: Int
    
    private let days: Int
    
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
    
    func getTitle(date: Int) -> String {
        return "\(date)"
    }
    
    func startDate() -> Int {
        return self.year == metaData!.startYear && self.month == metaData!.startMonth ? metaData!.startDay : 1
    }
    
    func endDate() -> Int {
        return self.year == metaData!.endYear && self.month == metaData!.endMonth ? metaData!.endDay : self.days
    }
    
    func nDates() -> Int {
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

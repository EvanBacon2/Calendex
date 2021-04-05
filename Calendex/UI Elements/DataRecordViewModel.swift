//
//  DataRecordViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/4/21.
//

import CoreData
import Foundation
import SwiftUI

class DataRecordViewModel: ObservableObject {
    let coreContext = PersistenceController.shared.container.viewContext
    
    @Published var records: [(Int, [Bool])] = []
    
    init() {
        do {
            var cal = Calendar.current
            cal.timeZone = TimeZone(identifier: "UTC")!
            let years = try coreContext.fetch(Fetches.fetchYears())
            
            for year in years {
                var yearRecord: (Int, [Bool]) = (year.year, [])
                let days = try coreContext.fetch(Fetches.fetchDaysInYear(year: year.year))
                
                let firstDayOfYear = DateComponents(year: year.year, month: 1, day: 1)
                let lastDayOfYear = DateComponents(year: year.year, month: 12, day: 31)
                
                let firstDayOfRecord = DateComponents(year: days.first!.year, month: days.first!.month, day: days.first!.day)
                let lastDayOfRecord = DateComponents(year: days.last!.year, month: days.last!.month, day: days.last!.day)
                
                let gapToStart = cal.dateComponents([.day], from: firstDayOfYear, to: firstDayOfRecord)
                let gapToEnd = cal.dateComponents([.day], from: lastDayOfRecord, to: lastDayOfYear)
                
                let startPadding = Array(repeating: false, count: gapToStart.day!)
                let endPadding = Array(repeating: false, count: gapToEnd.day!)
                
                yearRecord.1 = startPadding
                for day in days {
                    yearRecord.1.append(day.info!.entries > 0)
                }
                yearRecord.1.append(contentsOf: endPadding)
                
                records.append(yearRecord)
            }
        } catch {
            print(error)
        }
    }
}

//
//  MonthViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import CoreData
import Foundation
import SwiftUI

class MonthViewModel: ObservableObject, DateShellViewModel {
    private let coreContext = PersistenceController.shared.container.viewContext
    
    private var metaData: Meta_Entity? = nil
    
    private let year: Int
    private let month: Int
    
    let bannerTitles: [String]
    
    init(year: Int, month: Int) {
        do {
            self.metaData = try coreContext.fetch(Fetches.fetchMetaData()).first
        } catch {
            print(error)
        }
        
        self.year = year
        self.month = month
        
        self.bannerTitles = ["January", "Febuary", "March", "April", "May", "June",
                             "July", "August", "September", "October", "November", "December"]
    }
    
    func getTitle(date: Int) -> String {
        return bannerTitles[date - 1]
    }
    func startDate() -> Int {
        return self.year == metaData!.startYear ? metaData!.startMonth : 1
    }
    
    func endDate() -> Int {
        return self.year == metaData!.endYear ? metaData!.endMonth : 12
    }
    
    func nDates() -> Int {
        if self.year > metaData!.startYear && self.year < metaData!.endYear {
            return 12
        } else if self.year == metaData!.startYear {
            return 13 - metaData!.startMonth
        } else {// if self.year == metaData.first!.endYear
            return metaData!.endMonth
        }
    }
}

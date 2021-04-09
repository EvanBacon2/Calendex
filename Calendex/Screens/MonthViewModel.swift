//
//  MonthViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import CoreData
import Foundation
import SwiftUI

class MonthViewModel {
    let coreContext = PersistenceController.shared.container.viewContext
    
    var metaData: Meta_Entity? = nil
    
    let year: Int
    let month: Int
    
    init(year: Int, month: Int) {
        do {
            self.metaData = try coreContext.fetch(Fetches.fetchMetaData()).first
        } catch {
            print(error)
        }
        
        self.year = year
        self.month = month
    }
    
    func startMonth() -> Int {
        return self.year == metaData!.startYear ? metaData!.startMonth : 1
    }
    
    func nMonths() -> Int {
        if self.year > metaData!.startYear && self.year < metaData!.endYear {
            return 12
        } else if self.year == metaData!.startYear {
            return 13 - metaData!.startMonth
        } else {// if self.year == metaData.first!.endYear
            return metaData!.endMonth
        }
    }
}

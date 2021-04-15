//
//  YearViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import CoreData
import Foundation
import SwiftUI

class YearViewModel: ObservableObject, DateShellViewModel {
    let coreContext = PersistenceController.shared.container.viewContext
    
    var metaData: Meta_Entity? = nil
    
    init() {
        do {
            self.metaData = try coreContext.fetch(Fetches.fetchMetaData()).first
        } catch {
            print(error)
        }
    }
    
    func getTitle(date: Int) -> String {
        return "\(date)"
    }
    
    func startDate() -> Int {
        return metaData!.startYear
    }
    
    func endDate() -> Int {
        return metaData!.endYear
    }
    
    func nDates() -> Int {
        return metaData!.endYear - metaData!.startYear
    }
}

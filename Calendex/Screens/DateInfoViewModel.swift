//
//  DateInfoViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import CoreData
import CoreGraphics
import Foundation

class DateInfoViewModel: ObservableObject {
    let coreContext = PersistenceController.shared.container.viewContext
    
    var dateInfo: Date_Info_Entity? = nil
    
    init(year: Int = -1, month: Int = -1, day: Int = -1) {
        do {
            dateInfo = try coreContext.fetch(Fetches.fetchDateInfo(year: year, month: month, day: day)).first
        } catch {
            print(error)
        }
    }
    
    func getRange(_ range: Range, lowBound: Int, highBound: Int) -> CGFloat {
        if let info = dateInfo {
            let dis = info.info?.distribution
            switch range {
            case .low:
                return dis![0..<thToI(lowBound)].reduce(0, { sum, val in sum + val.value }) * 100
            case .mid:
                return dis![thToI(lowBound)..<thToI(highBound)].reduce(0, { sum, val in sum + val.value }) * 100
            case .high:
                return dis![thToI(highBound)..<dis!.count].reduce(0, { sum, val in sum + val.value }) * 100
            }
        } else {
            return 0
        }
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
    }
}

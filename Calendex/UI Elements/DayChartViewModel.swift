//
//  DayChartViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 4/4/21.
//

import Foundation
import PromiseKit
import SwiftUI

class DayChartViewModel: ObservableObject {
    @Published var points: [(Int, Double)] = []
    
    private let day: Date
    
    init(day: Date) {
        self.day = day
        self.getPoints()
    }
    
    private func getPoints() {
        let cal = Calendar.current
        let dayEnd = cal.date(byAdding: .day, value: 1, to: self.day)!
        let dayLength = dayEnd.timeIntervalSince(self.day)
        
        firstly {
            EgvRequest.call(startDate: self.day, endDate: dayEnd)
        }.done { egvs in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            self.points = egvs.egvs.map {
                (Int($0.value),
                 formatter.date(from: $0.systemTime)!.timeIntervalSince(self.day) / dayLength)
            }
        }.catch { error in
            print(error)
        }
    }
}

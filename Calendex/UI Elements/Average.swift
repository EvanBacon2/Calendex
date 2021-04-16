//
//  Average.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct Average: Metric {
    @EnvironmentObject var goals: Goals
    
    var valueRange: ClosedRange<Int> = 60...400
    var step: Int = 5
    var thumbPadding: Int = 10
    var activeRanges: [Range] = [.low, .mid, .high]
    
    init(goals: EnvironmentObject<Goals>) {
        self._goals = goals
    }
    
    func getMetrics() -> [Binding<Int>] {
        return [$goals.lowBgThreshold, $goals.highBgThreshold]
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
            case .low: return goals.lowBgThreshold
            case .mid: return (goals.highBgThreshold - goals.lowBgThreshold) + 60
            case .high: return 460 - goals.highBgThreshold
        }
    }
    
    func getMetricVal(range: Range, vals: [Int]) -> Int {
        switch range {
            case .low: return vals[0]
            case .mid: return (vals[1] - vals[0]) + 60
            case .high: return 460 - vals[1]
        }
    }
}

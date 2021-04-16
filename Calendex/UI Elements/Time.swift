//
//  Time.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct Time: Metric {
    @EnvironmentObject var goals: Goals
    
    var valueRange: ClosedRange<Int> = 0...100
    var step: Int = 1
    var thumbPadding: Int = 0
    var activeRanges: Array<Range> = [.mid, .high]
    
    init(goals: EnvironmentObject<Goals>) {
        self._goals = goals
    }
    
    func getMetrics() -> Array<Binding<Int>> {
        return [$goals.TimeInRangeThreshold]
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
            case .low: return 0//not used
            case .mid: return goals.TimeInRangeThreshold
            case .high: return 100 - goals.TimeInRangeThreshold
        }
    }
    
    func getMetricVal(range: Range, vals: [Int]) -> Int {
        switch range {
            case .low: return 0//not used
            case .mid: return vals[0]
            case .high: return 100 - vals[0]
        }
    }
}

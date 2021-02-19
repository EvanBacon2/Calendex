//
//  Average.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct Average: Metric {
    @EnvironmentObject var goals: Goals
    
    init(goals: EnvironmentObject<Goals>) {
        self._goals = goals
    }
    
    var valueRange: ClosedRange<Int> = 60...400
    
    var thumbPadding: Int = 10
    
    var activeRanges: Array<Range> = [.low, .mid, .high]
    
    func getMetrics() -> Array<Binding<Int>> {
        return [$goals.lowBgThreshold, $goals.highBgThreshold]
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
        case .low:
            return goals.lowBgThreshold
        case .mid:
            return (goals.highBgThreshold - goals.lowBgThreshold) + 60
        case .high:
            return 460 - goals.highBgThreshold
        }
    }
}

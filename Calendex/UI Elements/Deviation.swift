//
//  Deviation.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct Deviation: Metric {
    @EnvironmentObject var goals: Goals
    
    init(goals: EnvironmentObject<Goals>) {
        self._goals = goals
    }
    
    var valueRange: ClosedRange<Int> = 0...100
    
    var step: Int = 1
    
    var thumbPadding: Int = 0
    
    var activeRanges: Array<Range> = [.mid, .high]
    
    func getMetrics() -> Array<Binding<Int>> {
        return [$goals.DeviationThreshold]
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
        case .low:
            return 0//not used
        case .mid:
            return goals.DeviationThreshold
        case .high:
            return 100 - goals.DeviationThreshold
        }
    }
}

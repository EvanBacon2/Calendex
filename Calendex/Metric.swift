//
//  Metric.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

protocol Metric {
    var valueRange: ClosedRange<Int> { get }
    
    var thumbPadding: Int { get }
    
    var activeRanges: Array<Range> { get }
    
    func getMetrics() -> Array<Binding<Int>>
    
    func getMetricVal(range: Range) -> Int
}

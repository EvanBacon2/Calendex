//
//  Metric.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

protocol Metric {
    var valueRange: ClosedRange<Int> { get }
    
    var step: Int { get }
    
    var thumbPadding: Int { get }
    
    var activeRanges: [Range] { get }
    
    func getMetrics() -> [Binding<Int>]
    
    func getMetricVal(range: Range) -> Int
    
    func getMetricVal(range: Range, vals: [Int]) -> Int
}

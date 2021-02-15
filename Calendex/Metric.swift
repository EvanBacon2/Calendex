//
//  Metric.swift
//  Calendex
//
//  Created by Evan Bacon on 2/14/21.
//

import SwiftUI

protocol Metric {
    var lowColor: Color { get }
    var midColor: Color { get }
    var highColor: Color { get }
    
    func getBar(range: Range, width: CGFloat) -> AnyView
    
    func getThumb(startPos: CGFloat,
                  lowThreshold: CGFloat,
                  highThreshold: CGFloat,
                  val: Binding<Int>) -> AnyView

    func barColor(range: Range) -> Color
    
    func calcWidth(range: Range) -> CGFloat

    func convertMetricToWidth(val: Int) -> CGFloat
    
    func convertWidthToMetric(width: CGFloat) -> Int
    
    func getMetricVal(range: Range) -> Int
}

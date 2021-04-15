//
//  TimeInRange.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct TimeInRange: View {
    var low: Int
    var mid: Int
    var high: Int
    
    let lowLessThanOne: Bool
    let midLessThanOne: Bool
    let highLessThanOne: Bool
    
    init(low: CGFloat, mid: CGFloat, high: CGFloat) {
        var lessCount = 0
        
        self.lowLessThanOne = low > 0.0 && low < 1.0
        let lowTime = self.lowLessThanOne ? 1 : low
        if lowLessThanOne { lessCount += 1 }
        
        self.midLessThanOne = mid > 0.0 && mid < 1.0
        let midTime = self.midLessThanOne ? 1 : mid
        if midLessThanOne { lessCount += 1 }
        
        self.highLessThanOne = high > 0.0 && high < 1.0
        let highTime = self.highLessThanOne ? 1 : high
        if highLessThanOne { lessCount += 1 }
        
        if lessCount == 0 {
            self.low = Int(round(lowTime))
            self.mid = Int(round(midTime))
            self.high = Int(round(highTime))
        } else {
            self.low = Int(lowTime)
            self.mid = Int(midTime)
            self.high = Int(highTime)
        }
        
        var finalAdj = 0
        let times = [self.low, self.mid, self.high]
        if times.reduce(0, +) == 99 { finalAdj = 1 }
        if times.reduce(0, +) == 101 { finalAdj = -1 }
        
        if times.max() == self.low { self.low += finalAdj }
        else if times.max() == self.mid { self.mid += finalAdj }
        else if times.max() == self.high { self.high += finalAdj }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Time in Range")
            Spacer().frame(height: Spacing.TRIPLE_SPACE)
            if (low == 0 && mid == 0 && high == 0) {
                EmptyTimeBar()
            } else {
                TimeBar(low, mid, high)
            }
            Spacer().frame(height: Spacing.TRIPLE_SPACE)
            RangeFields(low: low, lowLessThanOne: lowLessThanOne,
                        mid: mid, midLessThanOne: midLessThanOne,
                        high: high, highLessThanOne: highLessThanOne)
        }
    }
}

struct TimeInRange_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack() {
                TimeInRange(low: 30.0, mid: 40.0, high: 30.0)
                TimeInRange(low: 33.3, mid: 33.3, high: 33.3)
                TimeInRange(low: 30.5, mid: 30.5, high: 39.0)
                TimeInRange(low: 0.3, mid: 12.6, high: 86.1)
            }.environmentObject(Colors())
        }
    }
}

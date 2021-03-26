//
//  TimeInRange.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct TimeInRange: View {
    var low: CGFloat
    var mid: CGFloat
    var high: CGFloat
    
    init(low: CGFloat, mid: CGFloat, high: CGFloat) {
        self.low = low
        self.mid = mid
        self.high = high
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Time in Range").padding(.bottom, Spacing.DOUBLE_SPACE)
            TimeBar(low, mid, high)
        }
    }
}

struct TimeInRange_Previews: PreviewProvider {
    static var previews: some View {
        TimeInRange(low: 8, mid: 57, high: 35).environmentObject(Colors())
    }
}

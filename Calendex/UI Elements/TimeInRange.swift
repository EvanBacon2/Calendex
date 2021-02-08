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
    
    init(low: Int, mid: Int, high: Int) {
        self.low = low
        self.mid = mid
        self.high = high
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Time in Range").padding(.bottom, Spacing.DOUBLE_SPACE)
            TimeBar2(low, mid, high)
        }
    }
}

struct TimeInRange_Previews: PreviewProvider {
    static var previews: some View {
        TimeInRange(low: 8, mid: 57, high: 35)
    }
}

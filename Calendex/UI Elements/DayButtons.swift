//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtons: View {
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int
    
    init(topOffset: Int, bottomOffset: Int, dayCount: Int) {
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
        self.dayCount = dayCount
    }
    
    var body: some View {
        VStack(spacing: 5) {
            TopDayRow(offset: topOffset)
            MidDayRows(offset: topOffset, dayCount: dayCount)
            BottomDayRow(topOffset, bottomOffset, dayCount: dayCount)
        }
    }
}

struct DayButtons_Previews: PreviewProvider {
    static var previews: some View {
        DayButtons(topOffset: 2, bottomOffset: 1, dayCount: 21)
    }
}

//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DaySummary: View {
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int

    init(year: Int, month: Int) {
        let cal = Calendar.current
        let firstDay = DateComponents(
            year: year,
            month: month,
            weekdayOrdinal: 1)
        let firstDate = cal.date(from: firstDay)!
        topOffset = cal.component(.weekday, from: firstDate)
        dayCount = cal.range(of: .day, in: .month, for: firstDate)!.count
        let lastDay = DateComponents(
            year: year,
            month: month,
            day: dayCount)
        let lastDate = cal.date(from: lastDay)!
        bottomOffset = cal.component(.weekday, from: lastDate)
        dayCount -= (8 - topOffset) + (bottomOffset)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DowBanner().padding(.bottom, Spacing.DOUBLE_SPACE)
            
            DayButtons(topOffset: topOffset, bottomOffset: bottomOffset, dayCount: dayCount).padding(.bottom, Spacing.SINGLE_SPACE)
            
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: UIScreen.screenWidth * 0.85, height: 1).padding(.bottom, Spacing.SINGLE_SPACE)
            
            DataButtons()
        }
    }
}

struct DaySummary_Previews: PreviewProvider {
    static var previews: some View {
        DaySummary(year: 2021, month: 6)
    }
}

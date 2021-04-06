//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtons: View {
    @Binding var navDay: Int?
    
    let selected: String
    
    let year: Int
    let month: Int
    let topOffset: Int
    let bottomOffset: Int
    var dayCount: Int
    
    init(year: Int, month: Int, selected: String, navDay: Binding<Int?>) {
        self.selected = selected
        
        self.year = year
        self.month = month
        
        self._navDay = navDay
        
        let cal = Calendar.current
        let firstDay = DateComponents(
            year: year,
            month: month)
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
        VStack(spacing: UIScreen.screenHeight * 0.01) {
            TopDayRow(year: year, month: month, offset: topOffset, selected: selected, navDay: _navDay)
            MidDayRows(year: year, month: month, offset: topOffset, dayCount: dayCount, selected: selected, navDay: _navDay)
            BottomDayRow(year: year, month: month, topOffset, bottomOffset, dayCount: dayCount, selected: selected, navDay: _navDay)
        }
    }
}

struct DayButtons_Previews: PreviewProvider {
    static var previews: some View {
        //DayButtons(topOffset: 2, bottomOffset: 1, dayCount: 21)
        EmptyView()
    }
}

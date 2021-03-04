//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtons: View {
    @FetchRequest var dayInfo: FetchedResults<Date_Info_Entity>
    
    var selected: String
    
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int
    
    init(year: Int, month: Int, selected: String) {
        self._dayInfo = FetchRequest(fetchRequest: Fetches.fetchDaysInMonth(year: year, month: month))
        
        self.selected = selected
        
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
            TopDayRow(offset: topOffset, dayInfo: dayInfo, selected: selected)
            MidDayRows(offset: topOffset, dayCount: dayCount, dayInfo: dayInfo, selected: selected)
            BottomDayRow(topOffset, bottomOffset, dayCount: dayCount, dayInfo: dayInfo, selected: selected)
        }
    }
}

struct DayButtons_Previews: PreviewProvider {
    static var previews: some View {
        //DayButtons(topOffset: 2, bottomOffset: 1, dayCount: 21)
        EmptyView()
    }
}

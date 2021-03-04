//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthButtons: View {
    @FetchRequest var monthInfo: FetchedResults<Date_Info_Entity>
    
    var selected: String
    
    let year: Int
    
    init(year: Int, selected: String) {
        self._monthInfo = FetchRequest(fetchRequest: Fetches.fetchMonthsInYear(year: year))
        self.selected = selected
        self.year = year
    }
    
    var body: some View {
        VStack(spacing: UIScreen.screenWidth * 0.018) {
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jan", year: year, month: 1, monthInfo: monthInfo[0], selected: selected)
                MonthButton("Feb", year: year, month: 2, monthInfo: monthInfo[1], selected: selected)
                MonthButton("Mar", year: year, month: 3, monthInfo: monthInfo[2], selected: selected)
                MonthButton("Apr", year: year, month: 4, monthInfo: monthInfo[3], selected: selected)
                MonthButton("May", year: year, month: 5, monthInfo: monthInfo[4], selected: selected)
                MonthButton("Jun", year: year, month: 6, monthInfo: monthInfo[5], selected: selected)
            }
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jul", year: year, month: 7, monthInfo: monthInfo[6], selected: selected)
                MonthButton("Aug", year: year, month: 8, monthInfo: monthInfo[7], selected: selected)
                MonthButton("Sep", year: year, month: 9, monthInfo: monthInfo[8], selected: selected)
                MonthButton("Oct", year: year, month: 10, monthInfo: monthInfo[9], selected: selected)
                MonthButton("Nov", year: year, month: 11, monthInfo: monthInfo[10], selected: selected)
                MonthButton("Dec", year: year, month: 12, monthInfo: monthInfo[11], selected: selected)
            }
        }
    }
}

struct MonthButtons_Previews: PreviewProvider {
    static var previews: some View {
        //MonthButtons(year: 2020)
        EmptyView()
    }
}

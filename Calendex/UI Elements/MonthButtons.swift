//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthButtons: View {
    @FetchRequest var monthInfo: FetchedResults<Date_Info_Entity>
    
    @State private var monthIndex: Int = 0
    
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
                ForEach(1..<7) { i in
                    MonthButton(year: year, month: i, selected: selected)
                }
            }
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                ForEach(7..<13) { i in
                    MonthButton(year: year, month: i, selected: selected)
                }
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

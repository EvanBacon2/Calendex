//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct MonthSummary: View {
    @EnvironmentObject var colors: Colors
    
    @State var selected: String = "Average"
    @State var navMonth: Int? = nil
    
    let year: Int
    
    init(year: Int) {
        self.year = year
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Month Summary")
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            MonthButtons(year: year, selected: selected, monthNav: $navMonth)
            Spacer().frame(height: Spacing.SINGLE_SPACE)
            seperator()
            Spacer().frame(height: Spacing.SINGLE_SPACE)
            DataButtons(selected: $selected)
        }.navigate(using: $navMonth, destination: makeMonth)
    }
    
    @ViewBuilder
    func makeMonth(for month: Int) -> some View {
        Month(year: year, month: month)
    }
    
    func seperator() -> some View {
        return Rectangle()
            .fill(colors.LIGHT_BLUE_GRAY)
            .frame(width: UIScreen.screenWidth * 0.85, height: 1)
    }
}

struct MonthSummary_Previews: PreviewProvider {
    static var previews: some View {
        MonthSummary(year: 2020).environmentObject(Colors())
    }
}

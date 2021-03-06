//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DaySummary: View {
    @State var selected: String = "Average"
    @State var navDay: Int? = nil
    
    let year: Int
    let month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DowBanner()
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            DayButtons(year: year, month: month, selected: selected, navDay: $navDay)
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            Rectangle()
                .fill(AppColors.DARK_GRAY)
                .frame(width: UIScreen.screenWidth * 0.85, height: 1).padding(.bottom, Spacing.DOUBLE_SPACE)
            DataButtons(selected: $selected)
        }.navigate(using: $navDay, destination: makeDay)
    }
    
    @ViewBuilder
    func makeDay(for day: Int) -> some View {
        DateShell(year: year, month: month, day: day)
    }
}

struct DaySummary_Previews: PreviewProvider {
    static var previews: some View {
        DaySummary(year: 2021, month: 2).environmentObject(Colors())
    }
}

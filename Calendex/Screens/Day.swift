//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    let blockSpace = UIScreen.screenHeight * 0.02
    
    let day: Int
    
    init(day: Int) {
        self.day = day
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("14")
            ScrollView {
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                VStack(spacing: 0) {
                    DayChart()
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    DayQuickData()
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    TimeInRange(low: 8, mid: 57, high: 35)
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    StandardDeviation()
                }.frame(width: UIScreen.screenWidth)
            }
        }.navigationBarItems(trailing: SettingsButton())
    }
}

struct Day_Previews: PreviewProvider {
    static var previews: some View {
        Day(day: 12).environmentObject(Colors())
                    .environmentObject(Goals())
    }
}

//
//  DaySummary.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DaySummary: View {
    @EnvironmentObject var colors: Colors
    
    @State var selected: String = "Average"
    
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
            DayButtons(year: year, month: month, selected: selected)
            Spacer().frame(height: Spacing.SINGLE_SPACE)
            Rectangle()
                .fill(colors.LIGHT_BLUE_GRAY)
                .frame(width: UIScreen.screenWidth * 0.85, height: 1).padding(.bottom, Spacing.SINGLE_SPACE)
            
            DataButtons(selected: $selected)
        }
    }
}

struct DaySummary_Previews: PreviewProvider {
    static var previews: some View {
        DaySummary(year: 2021, month: 2).environmentObject(Colors())
    }
}

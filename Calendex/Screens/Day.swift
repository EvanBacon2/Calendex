//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    var blockSpace = UIScreen.screenHeight * 0.02
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                ScreenHeader(title: "", banner: "15")
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                ScrollView {
                    VStack(spacing: 0) {
                        DayChart()
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        DayQuickData()
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        TimeInRange(low: 8, mid: 57, high: 35)
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        StandardDeviation()
                    }
                }
            }
        }
    }
}

struct Day_Previews: PreviewProvider {
    static var previews: some View {
        Day().environmentObject(Colors())
    }
}

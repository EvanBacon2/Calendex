//
//  Month.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Month: View {
    var year: Int
    var month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                ScreenHeader(title: "", banner: "January").padding(.bottom, Spacing.HEADER_MARGIN)
                ScrollView {
                    VStack(spacing: 0) {
                    DaySummary(year: year, month: month).padding(.bottom, Spacing.TRIPLE_SPACE)
                        TimeInRange(low: 8, mid: 57, high: 35).padding(.bottom, Spacing.DOUBLE_SPACE)
                        StandardDeviation()
                    }
                }
            }
        }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        Month(year: 2025, month: 7)
    }
}

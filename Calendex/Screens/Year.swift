//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                ScreenHeader(title: "Welcome", banner: "2020").padding(.bottom, Spacing.HEADER_MARGIN)
                ScrollView() {
                    VStack(spacing: 0) {
                        MonthSummary().padding(.bottom, Spacing.DOUBLE_SPACE)
                        TimeInRange(low: 8, mid: 57, high: 35).padding(.bottom, Spacing.DOUBLE_SPACE)
                        StandardDeviation()
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Year_Previews: PreviewProvider {
    static var previews: some View {
        Year()
    }
}

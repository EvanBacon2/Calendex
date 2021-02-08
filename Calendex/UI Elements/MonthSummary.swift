//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct MonthSummary: View {
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Month Summary").padding(.bottom, Spacing.DOUBLE_SPACE)
            
            MonthButtons().padding(.bottom, Spacing.SINGLE_SPACE)
            
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: UIScreen.screenWidth * 0.85, height: 1)
                .padding(.bottom, Spacing.SINGLE_SPACE)
            
            DataButtons()
        }
    }
}

struct MonthSummary_Previews: PreviewProvider {
    static var previews: some View {
        MonthSummary()
    }
}

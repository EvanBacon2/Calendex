//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthButtons: View {
    var body: some View {
        VStack(spacing: UIScreen.screenWidth * 0.018) {
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jul")
                MonthButton("Aug")
                MonthButton("Sep")
                MonthButton("Oct")
                MonthButton("Nov")
                MonthButton("Dec")
            }
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jul")
                MonthButton("Aug")
                MonthButton("Sep")
                MonthButton("Oct")
                MonthButton("Nov")
                MonthButton("Dec")
            }
        }
    }
}

struct MonthButtons_Previews: PreviewProvider {
    static var previews: some View {
        MonthButtons()
    }
}

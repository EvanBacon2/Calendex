//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthSummary: View {
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 6) {
                MonthButton("Jan")
                MonthButton("Feb")
                MonthButton("Mar")
                MonthButton("Apr")
                MonthButton("May")
                MonthButton("Jun")
            }.frame(width: UIScreen.screenWidth * 0.9)
            HStack(spacing: 6) {
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

struct MonthSummary_Previews: PreviewProvider {
    static var previews: some View {
        MonthSummary()
    }
}

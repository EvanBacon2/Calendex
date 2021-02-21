//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthButtons: View {
    let year: Int
    
    init(year: Int) {
        self.year = year
    }
    
    var body: some View {
        VStack(spacing: UIScreen.screenWidth * 0.018) {
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jan", year: year, month: 1)
                MonthButton("Feb", year: year, month: 2)
                MonthButton("Mar", year: year, month: 3)
                MonthButton("Apr", year: year, month: 4)
                MonthButton("May", year: year, month: 5)
                MonthButton("Jun", year: year, month: 6)
            }
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                MonthButton("Jul", year: year, month: 7)
                MonthButton("Aug", year: year, month: 8)
                MonthButton("Sep", year: year, month: 9)
                MonthButton("Oct", year: year, month: 10)
                MonthButton("Nov", year: year, month: 11)
                MonthButton("Dec", year: year, month: 12)
            }
        }
    }
}

struct MonthButtons_Previews: PreviewProvider {
    static var previews: some View {
        MonthButtons(year: 2020)
    }
}

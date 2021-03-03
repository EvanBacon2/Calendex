//
//  Month.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Month: View {
    @State var settingsActive: Bool = false
    
    let year: Int
    let month: Int
    let months: [String]

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        self.months = ["January", "Febuary", "March",
                       "April", "May", "June",
                       "July", "August", "September",
                       "October", "November", "December"]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner(months[month-1])
            ScrollView {
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                VStack(spacing: 0) {
                    DaySummary(year: year, month: month)
                    Spacer().frame(height: Spacing.TRIPLE_SPACE)
                    TimeInRange(low: 8, mid: 57, high: 35)
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    //StandardDeviation()
                }.frame(width: UIScreen.screenWidth)
            }
            settingsLink()
        }.navigationBarTitle("Month", displayMode: .inline)
        .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(),
                              isActive: $settingsActive) {
            EmptyView()
        }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        Month(year: 2025, month: 7).environmentObject(Colors())
                                   .environmentObject(Goals())
    }
}

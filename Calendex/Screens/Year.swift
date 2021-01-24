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
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    ScreenTitle("Welcome")
                    OverheadBanner("2020")
                }
                Spacer().frame(height: 25)
                SubBanner("Month Summary")
                VStack(alignment: .center, spacing: 5) {
                    Spacer().frame(height: 10)
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
                    Spacer().frame(height: 0)
                    Rectangle()
                        .fill(AppColors.LIGHT_BLUE_GRAY)
                        .frame(width: UIScreen.screenWidth * 0.85, height: 1)
                    Spacer().frame(height: 0)
                    HStack(spacing: 15) {
                        DataButton("Average")
                        DataButton("Range")
                        DataButton("Deviation")
                    }
                }
                Spacer().frame(height: 15)
                SubBanner("Time in Range")
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    TimeBar2(8, 5, 87)
                }.frame(width: UIScreen.screenWidth * 0.9 )
                Spacer().frame(height: 10)
                SubBanner("Standard Deviation")
                Spacer()
            }
        }
    }
}

struct Year_Previews: PreviewProvider {
    static var previews: some View {
        Year()
    }
}

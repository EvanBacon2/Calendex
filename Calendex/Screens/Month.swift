//
//  Month.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Month: View {
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int

    init(year: Int, month: Int) {
        let cal = Calendar.current
        let firstDay = DateComponents(
            year: year,
            month: month,
            weekdayOrdinal: 1)
        let firstDate = cal.date(from: firstDay)!
        topOffset = cal.component(.weekday, from: firstDate)
        dayCount = cal.range(of: .day, in: .month, for: firstDate)!.count
        let lastDay = DateComponents(
            year: year,
            month: month,
            day: dayCount)
        let lastDate = cal.date(from: lastDay)!
        bottomOffset = cal.component(.weekday, from: lastDate)
        dayCount -= (8 - topOffset) + (bottomOffset)
    }
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                VStack() {
                    ScreenTitle("Welcome")
                    OverheadBanner("January")
                }
                ScrollView {
                    //Spacer().frame(height: 15)
                    Group {
                    DowBanner()
                    DaySummary(topOffset: topOffset, bottomOffset: bottomOffset, dayCount: dayCount)
                    Spacer().frame(height: 10)
                    Rectangle()
                        .fill(AppColors.LIGHT_BLUE_GRAY)
                        .frame(width: UIScreen.screenWidth * 0.85, height: 1)
                    Spacer().frame(height: 10)
                    HStack(spacing: 15) {
                        DataButton("Average")
                        DataButton("Range")
                        DataButton("Deviation")
                    }
                    Spacer().frame(height: 15)
                    }
                    Group {
                        SubBanner("Time in Range")
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            TimeBar2(8, 5, 87)
                        }.frame(width: UIScreen.screenWidth * 0.9)
                    }
                    Spacer().frame(height: 10)
                    Group {
                        SubBanner("Standard Deviation")
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            DeviationGraph()
                        }.frame(width: UIScreen.screenWidth * 0.9)
                    }
                }
                //Spacer()
            }
        }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        Month(year: 2025, month: 7)
    }
}

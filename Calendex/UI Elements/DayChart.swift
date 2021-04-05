//
//  DayChart.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI
import PromiseKit

struct DayChart: View {
    @EnvironmentObject var goals: Goals
    
    @StateObject private var viewModel: DayChartViewModel
    
    init(day: Date_Info_Entity) {
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        let dayDate = cal.date(from: DateComponents(year: day.year, month: day.month, day: day.day))!
    
        self._viewModel = StateObject(wrappedValue: DayChartViewModel(day: dayDate))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack() {
                DayChartBackground(lowCutoff: goals.lowBgThreshold,
                                   highCutoff: goals.highBgThreshold)
                PointGraph(viewModel.points)
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayChart_Previews: PreviewProvider {
    static var previews: some View {
        /*DayChart().environmentObject(Colors())
                  .environmentObject(Goals())*/
        EmptyView()
    }
}

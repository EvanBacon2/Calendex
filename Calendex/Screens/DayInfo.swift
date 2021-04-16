//
//  DayInfo.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import SwiftUI

struct DayInfo: View {
    @EnvironmentObject var goals: Goals
    
    @ObservedObject var viewModel: DateInfoViewModel
    @ObservedObject private var chartViewModel: DayChartViewModel
    
    init(year: Int, month: Int, day: Int) {
        print("date info init: \(year), \(month), \(day)")
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        let dayDate = cal.date(from: DateComponents(year: year, month: month, day: day))!
        self._viewModel = ObservedObject(wrappedValue: DateInfoViewModel(year: year, month: month, day: day))
        self._chartViewModel = ObservedObject(wrappedValue: DayChartViewModel(day: dayDate))
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            Spacer().frame(height: Spacing.HEADER_MARGIN)
            DayChart(points: chartViewModel.points)
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            UIBox {
                DayQuickData(min: viewModel.dateInfo?.info?.measures?.min ?? -1,
                             max: viewModel.dateInfo?.info?.measures?.max ?? -1,
                             avg: Int(viewModel.dateInfo?.info?.measures?.mean ?? -1.0))
            }
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            UIBox {
                TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
            }
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            UIBox {
                Distribution(distribution: viewModel.dateInfo?.date_info?.distribution?.map { CGFloat($0.value * 100) } ?? viewModel.emptyDistribution)
            }
        }.padding(.bottom, Spacing.DOUBLE_SPACE)
    }
    
    func getRange(_ range: Range) -> CGFloat {
        return viewModel.getRange(range, lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
    }
}

struct DayInfo_Previews: PreviewProvider {
    static var previews: some View {
        //DayInfo()
        EmptyView()
    }
}

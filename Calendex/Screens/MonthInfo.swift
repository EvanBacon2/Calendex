//
//  MonthInfo.swift
//  Calendex
//
//  Created by Evan Bacon on 4/7/21.
//

import SwiftUI

struct MonthInfo: View {
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: DateInfoViewModel
    
    init(year: Int, month: Int) {
        self._viewModel = StateObject(wrappedValue: DateInfoViewModel(year: year, month: month))
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            Spacer().frame(height: Spacing.HEADER_MARGIN)
            DaySummary(year: viewModel.dateInfo!.year, month: viewModel.dateInfo!.month)
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            Distribution(distribution: (viewModel.dateInfo!.date_info?.distribution)!)
            Spacer()
        }
    }
    
    func getRange(_ range: Range) -> CGFloat {
        return viewModel.getRange(range, lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
    }
}

struct MonthInfo_Previews: PreviewProvider {
    static var previews: some View {
        MonthInfo(year: 2016, month: 4)
    }
}

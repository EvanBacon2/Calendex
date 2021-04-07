//
//  YearInfo.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import SwiftUI

struct YearInfo: View {
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: DateInfoViewModel
    
    init(year: Int) {
        self._viewModel = StateObject(wrappedValue: DateInfoViewModel(year: year))
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            Spacer().frame(height: Spacing.HEADER_MARGIN)
            MonthSummary(year: viewModel.dateInfo!.year)
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

struct YearInfo_Previews: PreviewProvider {
    static var previews: some View {
        YearInfo(year: 2016).environmentObject(Goals())
    }
}

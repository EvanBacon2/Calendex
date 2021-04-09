//
//  DayInfo.swift
//  Calendex
//
//  Created by Evan Bacon on 4/8/21.
//

import SwiftUI

struct DayInfo: View {
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: DateInfoViewModel
    
    init(year: Int, month: Int, day: Int) {
        self._viewModel = StateObject(wrappedValue: DateInfoViewModel(year: year, month: month, day: day))
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            Spacer().frame(height: Spacing.HEADER_MARGIN)
            DayChart(day: viewModel.dateInfo!)
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            DayQuickData(min: viewModel.dateInfo!.info?.measures?.min ?? -1,
                         max: viewModel.dateInfo!.info?.measures?.max ?? -1,
                         avg: Int(viewModel.dateInfo!.info?.measures?.mean ?? -1.0))
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            Distribution(distribution: (viewModel.dateInfo!.date_info?.distribution)!)
        }
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

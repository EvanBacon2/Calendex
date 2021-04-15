//
//  YearInfo.swift
//  Calendex
//
//  Created by Evan Bacon on 4/6/21.
//

import SwiftUI

struct YearInfo: View {
    @EnvironmentObject var goals: Goals
    
    @ObservedObject var viewModel: DateInfoViewModel
    
    init(year: Int) {
        self._viewModel = ObservedObject(wrappedValue: DateInfoViewModel(year: year))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: Spacing.HEADER_MARGIN)
            UIBox() {
                MonthSummary(year: viewModel.dateInfo?.year ?? 0)
            }
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            UIBox() {
                TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
            }
            Spacer().frame(height: Spacing.DOUBLE_SPACE)
            UIBox {
                Distribution(distribution: viewModel.dateInfo?.date_info?.distribution?.map { $0.value * 100 } ?? Array(repeating: 0, count: 36))
            }
            Spacer()
        }.padding(.bottom, Spacing.DOUBLE_SPACE)
        
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

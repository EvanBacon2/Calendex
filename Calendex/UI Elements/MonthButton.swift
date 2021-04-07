//
//  MonthButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct MonthButton: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @Binding var monthNav: Int?
    
    @StateObject var viewModel: DateButtonViewModel
    
    let selected: String
    let year: Int
    let month: Int
    let monthNames: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    let buttonWidth = UIScreen.screenWidth * 0.125
    let buttonHeight = UIScreen.screenWidth * 0.125 * 1.4
    let buttonCorner: CGFloat = 8
    
    init(year: Int, month: Int, selected: String, monthNav: Binding<Int?>) {
        self._monthNav = monthNav
        self._viewModel = StateObject(wrappedValue: DateButtonViewModel(year: year, month: month))
        
        self.selected = selected
        self.year = year
        self.month = month
    }
    
    var body: some View {
        if viewModel.dateHasData() {
            Button {
                self.monthNav = month
            } label: {
                monthRec()
            }.frame(width: buttonWidth, height: buttonHeight)
        } else {
           monthRec()
        }
    }
    
    func monthRec() -> some View {
        let active = viewModel.dateHasData()
        
        return Text(monthNames[month - 1])
                  .foregroundColor(active ? Color.white: colors.DARK_GRAY)
                  .frame(width: buttonWidth, height: buttonHeight)
                  .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                                .fill(active ? colors.getActiveColor(range: getRange()) : colors.LIGHT_BLUE_GRAY)
                                .frame(width: buttonWidth, height: buttonHeight)
                                .shadow(radius: 6, y: 6))
    }
    
    func getRange() -> Range {
        if (selected == "Average") {
            return viewModel.getAvgRange(lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
        } else if (selected == "Range") {
            return viewModel.getTimeRange(timeBound: goals.TimeInRangeThreshold,
                                          lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
        } else {//if selected == "Deviation"
            return viewModel.getStdDevRange(devBound: goals.DeviationThreshold)
        }
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
    }
}

struct MonthButton_Previews: PreviewProvider {
    static var previews: some View {
        //MonthButton("Mar", year: 2020, month: 3).environmentObject(Colors())
        EmptyView()
    }
}

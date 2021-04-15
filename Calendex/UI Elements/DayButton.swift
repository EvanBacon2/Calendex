//
//  DayButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButton: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @Binding var navDay: Int?
    
    @ObservedObject var viewModel: DateButtonViewModel
    
    let day: Int
    let selected: String
    let buttonLength = UIScreen.screenWidth * 0.9 / 9
    let buttonCorner: CGFloat = 6
    
    init(year: Int, month: Int, day: Int, selected: String, navDay: Binding<Int?>) {
        self._navDay = navDay
        
        self._viewModel = ObservedObject(wrappedValue: DateButtonViewModel(year: year, month: month, day: day))
        
        self.day = day
        self.selected = selected
    }
    
    var body: some View {
        if viewModel.dateHasData() {
            Button {
                self.navDay = day
            } label: {
                dayRec()
            }.frame(width: buttonLength, height: buttonLength)
        } else {
            dayRec()
        }
    }
    
    func dayRec() -> some View {
        let active = viewModel.dateHasData()
        
        return Text("\(day)")
            .font(.callout)
            .foregroundColor(active ? Color.white : AppColors.DARK_GRAY)
            .frame(width: buttonLength, height: buttonLength)
            .background(RoundedRectangle(cornerRadius: buttonCorner)
                            .fill(active ? colors.activeColor(range: getRange()) : AppColors.LIGHT_BLUE_GRAY)
                            .frame(width: buttonLength, height: buttonLength))
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
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        //DayButton(1).environmentObject(Colors())
        EmptyView()
    }
}

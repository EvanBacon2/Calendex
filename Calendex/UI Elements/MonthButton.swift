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
    
    var selected: String
    
    let label: String
    let year: Int
    let month: Int
    
    let monthInfo: Date_Info_Entity
    
    var buttonWidth = UIScreen.screenWidth * 0.125
    var buttonHeight = UIScreen.screenWidth * 0.125 * 1.4
    var buttonCorner: CGFloat = 8
    
    init(_ label: String, year: Int, month: Int, monthInfo: Date_Info_Entity, selected: String) {
        self.label = label
        self.year = year
        self.month = month
        
        self.monthInfo = monthInfo
        
        self.selected = selected
    }
    
    var body: some View {
        NavigationLink(destination: Month(year: year, month: month, monthInfo: monthInfo)) {
            Text(self.label)
                .foregroundColor(Color.white)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                                .fill(colors.getActiveColor(range: getRange()))
                                .frame(width: buttonWidth, height: buttonHeight)
                                .shadow(radius: 6, y: 6))
        }
    }
    
    func getRange() -> Range {
        if (selected == "Average") {
            let mean = monthInfo.info?.measures?.mean ?? 0.0
            
            if (mean < CGFloat(goals.lowBgThreshold)) {
                return .low
            } else if (mean > CGFloat(goals.highBgThreshold)) {
                return .high
            } else {
                return .mid
            }
        } else if (selected == "Range") {
            let range = monthInfo.info?.timeInRange?.midTime ?? 0.0
            
            if (range >= CGFloat(goals.TimeInRangeThreshold)) {
                return .mid
            } else {
                return .high
            }
        } else {//if selected == "Deviation"
            let deviation = monthInfo.info?.measures?.stdDeviation ?? 0.0
            
            if (deviation <= CGFloat(goals.DeviationThreshold)) {
                return .mid
            } else {
                return .high
            }
        }
    }
}

struct MonthButton_Previews: PreviewProvider {
    static var previews: some View {
        //MonthButton("Mar", year: 2020, month: 3).environmentObject(Colors())
        EmptyView()
    }
}

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
    
    var selected: String
    
    var day: Int
    var buttonLength = UIScreen.screenWidth * 0.9 / 9
    var buttonCorner: CGFloat = 6
    
    let dayInfo: Date_Info_Entity
    
    init(_ day: Int, dayInfo: Date_Info_Entity, selected: String) {
        self.day = day
        self.dayInfo = dayInfo
        self.selected = selected
    }
    
    var body: some View {
        NavigationLink(destination: Day(day: day, dayInfo: dayInfo)) {
            Text("\(day)")
                .font(.callout)
                .foregroundColor(Color.white)
                .frame(width: buttonLength, height: buttonLength)
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                .fill(colors.getActiveColor(range: getRange()))
                .frame(width: buttonLength, height: buttonLength))
        }
    }
    
    func getRange() -> Range {
        if (selected == "Average") {
            let mean = dayInfo.info?.measures?.mean ?? 0.0
            
            if (mean < CGFloat(goals.lowBgThreshold)) {
                return .low
            } else if (mean > CGFloat(goals.highBgThreshold)) {
                return .high
            } else {
                return .mid
            }
        } else if (selected == "Range") {
            let range = dayInfo.info?.timeInRange?.midTime ?? 0.0
            
            if (range >= CGFloat(goals.TimeInRangeThreshold)) {
                return .mid
            } else {
                return .high
            }
        } else {//if selected == "Deviation"
            let deviation = dayInfo.info?.measures?.stdDeviation ?? 0.0
            
            if (deviation <= CGFloat(goals.DeviationThreshold)) {
                return .mid
            } else {
                return .high
            }
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        //DayButton(1).environmentObject(Colors())
        EmptyView()
    }
}

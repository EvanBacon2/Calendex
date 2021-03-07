//
//  DayButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButton: View {
    @FetchRequest var dayInfo: FetchedResults<Date_Info_Entity>
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    let day: Int
    let selected: String
    let buttonLength = UIScreen.screenWidth * 0.9 / 9
    let buttonCorner: CGFloat = 6
    
    init(year: Int, month: Int, day: Int, selected: String) {
        self._dayInfo = FetchRequest(fetchRequest: Fetches.fetchDateInfo(year: year, month: month, day: day))
        
        self.day = day
        self.selected = selected
    }
    
    var body: some View {
        if !dayInfo.isEmpty {
            NavigationLink(destination: Day(day: day, dayInfo: dayInfo.first!)) {
                dayRec()
            }
        } else {
            dayRec()
        }
    }
    
    func dayRec() -> some View {
        let active = !dayInfo.isEmpty
        
        return Text("\(day)")
            .font(.callout)
            .foregroundColor(active ? Color.white : colors.DARK_GRAY)
            .frame(width: buttonLength, height: buttonLength)
            .background(RoundedRectangle(cornerRadius: buttonCorner)
                            .fill(active ? colors.getActiveColor(range: getRange()) : colors.LIGHT_BLUE_GRAY)
                            .frame(width: buttonLength, height: buttonLength))
    }
    
    func getRange() -> Range {
        if selected == "Average" {
            let mean = dayInfo.first!.info?.measures?.mean ?? 0.0
            
            if (mean < CGFloat(goals.lowBgThreshold)) {
                return .low
            } else if (mean > CGFloat(goals.highBgThreshold)) {
                return .high
            } else {
                return .mid
            }
        } else if selected == "Range" {
            let range = dayInfo.first!.info?.timeInRange?.midTime ?? 0.0
            
            if (range >= CGFloat(goals.TimeInRangeThreshold)) {
                return .mid
            } else {
                return .high
            }
        } else {//if selected == "Deviation"
            let deviation = dayInfo.first!.info?.measures?.stdDeviation ?? 0.0
            
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

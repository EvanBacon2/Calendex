//
//  MonthButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct MonthButton: View {
    //@FetchRequest var monthInfo: FetchedResults<Date_Info_Entity>
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @Binding var monthNav: Int?
    
    let selected: String
    let year: Int
    let month: Int
    let monthNames: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    let buttonWidth = UIScreen.screenWidth * 0.125
    let buttonHeight = UIScreen.screenWidth * 0.125 * 1.4
    let buttonCorner: CGFloat = 8
    
    init(year: Int, month: Int, selected: String, monthNav: Binding<Int?>) {
        //self._monthInfo = FetchRequest(fetchRequest: Fetches.fetchDateInfo(year: year, month: month))
        
        self._monthNav = monthNav
        
        self.selected = selected
        self.year = year
        self.month = month
    }
    
    var body: some View {
        //if !self.monthInfo.isEmpty && self.monthInfo.first!.info!.entries > 0 {
            Button {
                self.monthNav = month
            } label: {
                monthRec()
            }.frame(width: buttonWidth, height: buttonHeight)
        //} else {
           // monthRec()
        //}
    }
    
    func monthRec() -> some View {
        let active = true//!self.monthInfo.isEmpty
        
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
            let mean = CGFloat(84.0)//monthInfo.first!.info?.measures?.mean ?? 0.0
            
            if (mean < CGFloat(goals.lowBgThreshold)) {
                return .low
            } else if (mean > CGFloat(goals.highBgThreshold)) {
                return .high
            } else {
                return .mid
            }
        } else if (selected == "Range") {
            let range = CGFloat(72.0) //monthInfo.first!.info!.distribution![thToI(goals.lowBgThreshold)..<thToI(goals.highBgThreshold)].reduce(0, { sum, val in sum + val.value }) * 100
            
            if (range >= CGFloat(goals.TimeInRangeThreshold)) {
                return .mid
            } else {
                return .high
            }
        } else {//if selected == "Deviation"
            let deviation = CGFloat(29.0)//monthInfo.first!.info?.measures?.stdDeviation ?? 0.0
            
            if (deviation <= CGFloat(goals.DeviationThreshold)) {
                return .mid
            } else {
                return .high
            }
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

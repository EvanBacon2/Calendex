//
//  BottomDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct BottomDayRow: View {
    @Binding var navDay: Int?
    
    var selected: String
    
    let year: Int
    let month: Int
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int
    
    init(year: Int, month: Int, _ topOffset: Int, _ bottomOffset: Int, dayCount: Int, selected: String, navDay: Binding<Int?>) {
        self.selected = selected
        
        self.year = year
        self.month = month
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
        self.dayCount = dayCount
        
        self._navDay = navDay
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                if (i > bottomOffset) {
                    DayButtonFiller()
                } else {
                    DayButton(year: year, month: month, day: index(i), selected: selected, navDay: _navDay)
                }
                Spacer()
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
    
    func index(_ i: Int) -> Int {
        return dayCount + i + (8 - topOffset)
    }
}

struct BottomDayRow_Previews: PreviewProvider {
    static var previews: some View {
        //BottomDayRow(6, 4, dayCount: 21)
        EmptyView()
    }
}

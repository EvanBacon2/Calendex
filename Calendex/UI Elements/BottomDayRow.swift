//
//  BottomDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct BottomDayRow: View {
    var selected: String
    
    var dayInfo: FetchedResults<Date_Info_Entity>
    
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int
    
    init(_ topOffset: Int, _ bottomOffset: Int, dayCount: Int, dayInfo: FetchedResults<Date_Info_Entity>, selected: String) {
        self.selected = selected
        
        self.dayInfo = dayInfo
        
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
        self.dayCount = dayCount
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                if (i > bottomOffset) {
                    DayButtonFiller()
                } else {
                    DayButton(index(i), dayInfo: dayInfo[index(i) - 1], selected: selected)
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

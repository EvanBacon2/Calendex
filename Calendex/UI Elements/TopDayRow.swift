//
//  TopDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct TopDayRow: View {
    var selected: String
    
    var offset: Int
    var dayInfo: FetchedResults<Date_Info_Entity>
    
    init(offset: Int, dayInfo: FetchedResults<Date_Info_Entity>, selected: String) {
        self.selected = selected
        self.dayInfo = dayInfo
        self.offset = offset
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                if (i < offset) {
                    DayButtonFiller()
                } else {
                    DayButton(index(i), dayInfo: dayInfo[index(i) - 1], selected: selected)
                }
                Spacer()
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
    
    func index(_ i: Int) -> Int {
        return i - (offset - 1)
    }
}

struct TopDayRow_Previews: PreviewProvider {
    static var previews: some View {
        /*VStack() {
            TopDayRow(offset: 1)
            TopDayRow(offset: 2)
            TopDayRow(offset: 3)
            TopDayRow(offset: 4)
            TopDayRow(offset: 5)
            TopDayRow(offset: 6)
            TopDayRow(offset: 7)
        }*/
        EmptyView()
    }
}

//
//  MidDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRow: View {
    var selected: String
    
    var dayInfo: FetchedResults<Date_Info_Entity>
    var offset: Int
    
    init(offset: Int, row: Int, dayInfo: FetchedResults<Date_Info_Entity>, selected: String) {
        self.selected = selected
        self.dayInfo = dayInfo
        self.offset = (7 * (row + 1)) - (offset - 1)
    }
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                DayButton(index(i), dayInfo: dayInfo[index(i) - 1], selected: selected)
                Spacer()
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
    
    func index(_ i: Int) -> Int {
        return i + offset
    }
}

struct MidDayRow_Previews: PreviewProvider {
    static var previews: some View {
        //MidDayRow(offset: 4, row: 0)
        EmptyView()
    }
}

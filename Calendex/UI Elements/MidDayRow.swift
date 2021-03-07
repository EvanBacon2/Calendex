//
//  MidDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRow: View {
    let selected: String
    
    let year: Int
    let month: Int
    let offset: Int
    
    init(year: Int, month: Int, offset: Int, row: Int, selected: String) {
        self.selected = selected
        self.year = year
        self.month = month
        self.offset = (7 * (row + 1)) - (offset - 1)
    }
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                DayButton(year: year, month: month, day: index(i), selected: selected)
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

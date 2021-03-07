//
//  MidDayRows.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRows: View {
    let selected: String
    
    let year: Int
    let month: Int
    let offset: Int
    let dayCount: Int
    
    init(year: Int, month: Int, offset: Int, dayCount: Int, selected: String) {
        self.selected = selected
        
        self.year = year
        self.month = month
        self.offset = offset
        self.dayCount = dayCount
    }
    
    var body: some View {
        ForEach(0..<dayCount/7) { i in
            MidDayRow(year: year, month: month, offset: offset, row: i, selected: selected)
        }
    }
}

struct MidDayRows_Previews: PreviewProvider {
    static var previews: some View {
        //MidDayRows(offset: 4, dayCount: 31)
        EmptyView()
    }
}

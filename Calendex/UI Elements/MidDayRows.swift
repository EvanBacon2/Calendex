//
//  MidDayRows.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRows: View {
    var offset: Int
    var dayCount: Int
    
    init(offset: Int, dayCount: Int) {
        self.offset = offset
        self.dayCount = dayCount
    }
    
    var body: some View {
        ForEach(0..<dayCount/7) { i in
            MidDayRow(offset: offset, row: i)
        }
    }
}

struct MidDayRows_Previews: PreviewProvider {
    static var previews: some View {
        MidDayRows(offset: 4, dayCount: 31)
    }
}

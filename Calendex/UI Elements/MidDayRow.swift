//
//  MidDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRow: View {
    var offset: Int
    
    init(offset: Int, row: Int) {
        self.offset = (7 * (row + 1)) - (offset - 1)
        
    }
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(1..<8) { i in
                DayButton(i + offset)
                Spacer()
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct MidDayRow_Previews: PreviewProvider {
    static var previews: some View {
        MidDayRow(offset: 4, row: 0)
    }
}

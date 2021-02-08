//
//  BottomDayRow.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct BottomDayRow: View {
    var topOffset: Int
    var bottomOffset: Int
    var dayCount: Int
    
    init(_ topOffset: Int, _ bottomOffset: Int, dayCount: Int) {
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
                    DayButton(dayCount + i + (8 - topOffset))
                }
                Spacer()
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct BottomDayRow_Previews: PreviewProvider {
    static var previews: some View {
        BottomDayRow(6, 4, dayCount: 21)
    }
}

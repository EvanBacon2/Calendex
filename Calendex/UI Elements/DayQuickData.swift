//
//  DayQuickData.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DayQuickData: View {
    let min: Int
    let max: Int
    let avg: Int
    
    init(min: Int, max: Int, avg: Int) {
        self.min = min
        self.max = max
        self.avg = avg
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Summary").padding(.bottom, Spacing.DOUBLE_SPACE)
            DayFields(min: min, max: max, avg: avg)
        }
    }
}

struct DayQuickData_Previews: PreviewProvider {
    static var previews: some View {
        DayQuickData(min: 72, max: 173, avg: 114).environmentObject(Colors())
    }
}

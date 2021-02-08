//
//  DayChartBackground.swift
//  Calendex
//
//  Created by Evan Bacon on 1/31/21.
//

import SwiftUI

struct DayChartBackground: View {
    var lowCutoff: Int
    var highCutoff: Int
    
    init(lowCutoff: Int, highCutoff: Int) {
        self.lowCutoff = lowCutoff
        self.highCutoff = highCutoff
    }
    
    var body: some View {
        VStack(spacing: 3) {
            HighRangeBackground(cutoff: highCutoff)
            MidRangeBackground(lowCutoff: lowCutoff, highCutoff: highCutoff)
            LowRangeBackground(cutoff: lowCutoff)
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayChartBackground_Previews: PreviewProvider {
    static var previews: some View {
        DayChartBackground(lowCutoff: 70, highCutoff: 140)
    }
}

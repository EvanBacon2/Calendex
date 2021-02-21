//
//  DayChart.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct DayChart: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack() {
                DayChartBackground(lowCutoff: goals.lowBgThreshold, highCutoff: goals.highBgThreshold)
                PointGraph([80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80])
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayChart_Previews: PreviewProvider {
    static var previews: some View {
        DayChart().environmentObject(Colors())
                  .environmentObject(Goals())
    }
}

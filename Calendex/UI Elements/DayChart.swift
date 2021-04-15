//
//  DayChart.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI
import PromiseKit

struct DayChart: View {
    @EnvironmentObject var goals: Goals
    
    let points: [(Int, Double)]
    
    init(points: [(Int, Double)]) {
        self.points = points
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack() {
                DayChartBackground(lowCutoff: goals.lowBgThreshold,
                                   highCutoff: goals.highBgThreshold)
                PointGraph(points)
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayChart_Previews: PreviewProvider {
    static var previews: some View {
        /*DayChart().environmentObject(Colors())
                  .environmentObject(Goals())*/
        EmptyView()
    }
}

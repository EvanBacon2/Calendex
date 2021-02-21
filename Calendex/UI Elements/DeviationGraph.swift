//
//  DeviationGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationGraph: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        VStack() {
            HStack(alignment: .top, spacing: UIScreen.screenHeight * 0.004) {
                VStack() {
                    Rectangle()
                        .fill(colors.LIGHT_BLUE_GRAY)
                        .frame(width: UIScreen.screenHeight * 0.004,
                               height: UIScreen.screenHeight * 0.1)
                        Spacer()
                }.frame(height: UIScreen.screenHeight * 0.114)
                Spacer().frame(width: UIScreen.screenHeight * 0.012)
                DeviationRange(lowVals(), .low)
                DeviationRangeMarker("\(goals.lowBgThreshold)")
                DeviationRange(midVals(), .mid)
                DeviationRangeMarker("\(goals.highBgThreshold)")
                DeviationRange(highVals(), .high)
            }
        }
    }
    
    func index(_ cutoff: Int) -> Int {
        return (cutoff - 40) / 10
    }
    
    func lowVals() -> [CGFloat] {
        return Array(repeating: 2.0, count: index(goals.lowBgThreshold))
    }
    
    func midVals() -> [CGFloat] {
        return Array(repeating: 2.0, count: index(goals.highBgThreshold) -                                   index(goals.lowBgThreshold))
    }
    
    func highVals() -> [CGFloat] {
        return Array(repeating: 2.0, count: index(400) -
                                            index(goals.highBgThreshold))
    }
}

struct DeviationGraph_Previews: PreviewProvider {
    static var previews: some View {
        DeviationGraph().environmentObject(Colors())
                        .environmentObject(Goals())
    }
}

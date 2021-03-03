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
    
    let distribution: [CGFloat]
    let ceiling: CGFloat
    
    init(distribution: [DistributionRange_Entity]) {
        self.distribution = distribution.map { $0.value }
        self.ceiling = self.distribution.max()!
    }
    
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
                DeviationRange(lowVals(), .low, ceiling)
                DeviationRangeMarker("\(goals.lowBgThreshold)")
                DeviationRange(midVals(), .mid, ceiling)
                DeviationRangeMarker("\(goals.highBgThreshold)")
                DeviationRange(highVals(), .high, ceiling)
            }
        }
    }
    
    func index(_ cutoff: Int) -> Int {
        return (cutoff - 40) / 10
    }
    
    func lowVals() -> [CGFloat] {
        return Array(distribution[0..<index(goals.lowBgThreshold)])
    }
    
    func midVals() -> [CGFloat] {
        return Array(distribution[index(goals.lowBgThreshold)..<index(goals.highBgThreshold)])
    }
    
    func highVals() -> [CGFloat] {
        return Array(distribution[index(goals.highBgThreshold)..<distribution.count])
    }
}

struct DeviationGraph_Previews: PreviewProvider {
    static var previews: some View {
        //DeviationGraph().environmentObject(Colors())
                        //.environmentObject(Goals())
        EmptyView()
    }
}

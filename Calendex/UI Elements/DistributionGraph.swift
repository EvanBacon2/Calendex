//
//  DistributionGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DistributionGraph: View {
    @EnvironmentObject var goals: Goals
    
    var distribution: [CGFloat] = Array(repeating: 0, count: 36)
    let ceiling: CGFloat
    
    let baseAngleOffset = 15.0
    
    init(distribution: [CGFloat]) {
        self.distribution = distribution
        self.ceiling = self.distribution.max() ?? 0
    }
    
    var body: some View {
        VStack() {
            HStack(alignment: .top, spacing: UIScreen.screenHeight * 0.004) {
                DistributionYAxis(ceiling: ceiling)
                Spacer().frame(width: UIScreen.screenHeight * 0.012)
                DistributionRange(lowVals(), .low, ceiling)
                DistributionRangeMarker("\(goals.lowBgThreshold)",
                                        angleOffset: angleOffset())
                DistributionRange(midVals(), .mid, ceiling)
                DistributionRangeMarker("\(goals.highBgThreshold)",
                                        angleOffset: -angleOffset())
                DistributionRange(highVals(), .high, ceiling)
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
    
    func angleOffset() -> Double {
        let goalDiff = goals.highBgThreshold - goals.lowBgThreshold
        let degreeOffset =  goalDiff <= 35 ? baseAngleOffset * Double((4 - (goalDiff / 10))) : 0.0
        return Double.pi / (180.0 / degreeOffset)
    }
}

struct DistributionGraph_Previews: PreviewProvider {
    
    static var previews: some View {
        //DistributionGraph().environmentObject(Colors())
        //.environmentObject(Goals())
          EmptyView()
    }
}

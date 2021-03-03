//
//  StandardDeviation.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct StandardDeviation: View {
    let distribution: [DistributionRange_Entity]
    
    init(distribution: [DistributionRange_Entity]) {
        self.distribution = distribution
    }
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Standard Deviation").padding(.bottom, Spacing.DOUBLE_SPACE)
            DeviationGraph(distribution: distribution)
        }
    }
}

struct StandardDeviation_Previews: PreviewProvider {
    static var previews: some View {
        //StandardDeviation()
        EmptyView()
    }
}

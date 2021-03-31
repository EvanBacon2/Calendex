//
//  Distribution.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct Distribution: View {
    let distribution: [DistributionRange_Entity]
    
    init(distribution: [DistributionRange_Entity]) {
        self.distribution = distribution
    }
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Distribution").padding(.bottom, Spacing.DOUBLE_SPACE)
            DistributionGraph(distribution: distribution)
        }
    }
}

struct Distribution_Previews: PreviewProvider {
    static var previews: some View {
        //StandardDistribution()
        EmptyView()
    }
}

//
//  StandardDeviation.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct StandardDeviation: View {
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Standard Deviation").padding(.bottom, Spacing.DOUBLE_SPACE)
            DeviationGraph()
        }
    }
}

struct StandardDeviation_Previews: PreviewProvider {
    static var previews: some View {
        StandardDeviation()
    }
}

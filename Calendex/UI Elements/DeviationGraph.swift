//
//  DeviationGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationGraph: View {
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            VStack(){
                Rectangle()
                    .fill(AppColors.LIGHT_BLUE_GRAY)
                    .frame(width: 2, height: UIScreen.screenHeight * 0.1)
                    Spacer()
            }.frame(height: UIScreen.screenHeight * 0.1 + 7)
            Spacer().frame(width: 6)
            DeviationRange([1,1,1], .low)
            DeviationRangeMarker("70")
            DeviationRange([1,1,5,5,1,1], .mid)
            DeviationRangeMarker("140")
            DeviationRange([1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0], .high)
        }
    }
}

struct DeviationGraph_Previews: PreviewProvider {
    static var previews: some View {
        DeviationGraph()
    }
}

//
//  DeviationGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationGraph: View {
    @EnvironmentObject var colors: Colors
    
    var body: some View {
        HStack(alignment: .top, spacing: UIScreen.screenHeight * 0.004) {
            VStack(){
                Rectangle()
                    .fill(colors.LIGHT_BLUE_GRAY)
                    .frame(width: UIScreen.screenHeight * 0.004, height: UIScreen.screenHeight * 0.1)
                    Spacer()
            }.frame(height: UIScreen.screenHeight * 0.114)
            Spacer().frame(width: UIScreen.screenHeight * 0.012)
            DeviationRange([1,1,1], .low)
            DeviationRangeMarker("70")
            DeviationRange([1,1,4,5,1,1], .mid)
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

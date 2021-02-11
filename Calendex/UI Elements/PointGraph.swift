//
//  PointGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct PointGraph: View {
    var values: [CGFloat]
    
    init(_ values: [CGFloat]) {
        self.values = values
    }
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<values.count) { i in
                ChartPoint(values[i])
            }
        }.frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.4 + UIScreen.screenHeight * 0.012)
    }
}

struct PointGraph_Previews: PreviewProvider {
    static var previews: some View {
        PointGraph([70, 84, 83, 91, 143, 120, 120, 120, 120, 110, 120, 90, 100, 100, 100 ,100 ,100, 100, 100, 100, 100, 100, 200, 200])
    }
}

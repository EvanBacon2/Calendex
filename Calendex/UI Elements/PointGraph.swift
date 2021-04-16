//
//  PointGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct PointGraph: View {
    var values: [(Int, TimeInterval)]
    
    init(_ values: [(Int, TimeInterval)]) {
        self.values = values
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(0..<values.count, id: \.self) { i in
                ChartPoint(x: values[i].1, y: values[i].0)
            }
        }.frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.4 + UIScreen.screenHeight * 0.012)
    }
}

struct PointGraph_Previews: PreviewProvider {
    static var previews: some View {
        /*PointGraph([70, 84, 83, 91, 143, 120, 120, 120, 120, 110, 120, 90, 100, 100, 100 ,100 ,100, 100, 100, 100, 100, 100, 200, 200])*/
        EmptyView()
    }
}

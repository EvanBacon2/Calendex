//
//  ChartPoint.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct ChartPoint: View {
    @EnvironmentObject var colors: Colors
    
    var value: CGFloat
    
    init(_ value: CGFloat) {
        self.value = value
    }
    
    var body: some View {
        Circle()
            .strokeBorder(colors.LIGHT_BLUE_GRAY)
            .background(Circle()).foregroundColor(colors.DARK_GRAY)
            .frame(width: UIScreen.screenWidth * 0.8 / 24, height: UIScreen.screenHeight * 0.012)
            .offset(y: UIScreen.screenHeight * 0.4 * CGFloat(-(value - 220) / 360.0))
    }
}

struct ChartPoint_Previews: PreviewProvider {
    static var previews: some View {
        ChartPoint(220).environmentObject(Colors())
    }
}

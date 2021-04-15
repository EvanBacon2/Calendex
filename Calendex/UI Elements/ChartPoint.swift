//
//  ChartPoint.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct ChartPoint: View {
    var x: CGFloat
    var y: CGFloat
    
    init(x: Double, y: Int) {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
    
    var body: some View {
        Circle()
            .strokeBorder(AppColors.LIGHT_BLUE_GRAY)
            .background(Circle()).foregroundColor(AppColors.DARK_GRAY)
            .frame(width: UIScreen.screenWidth * 0.8 / 268, height: UIScreen.screenHeight * 0.012)
            .offset(x: (UIScreen.screenWidth * 0.8 * x) - UIScreen.screenWidth * 0.4,
                    y: UIScreen.screenHeight * 0.4 * CGFloat(-(y - 220) / 360.0))
    }
}

struct ChartPoint_Previews: PreviewProvider {
    static var previews: some View {
        /*ChartPoint(220).environmentObject(Colors())*/
        EmptyView()
    }
}

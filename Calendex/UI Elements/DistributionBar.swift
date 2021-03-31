//
//  DistributionBar.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DistributionBar: View {
    var percent: CGFloat
    var ceiling: CGFloat
    var color: Color
    var barWidth = UIScreen.screenWidth * 0.016
    var barHeight = Dimensions.BASE_UNIT * 50
    var emptyBarHeight = Dimensions.BASE_UNIT * 3
    
    init(_ color: Color, _ percent: CGFloat, _ ceiling: CGFloat) {
        self.color = color
        self.percent = percent
        self.ceiling = ceiling
    }
    
    var body: some View {
        if percent > 0.3 * (ceiling / 5) {
            RoundedRectangle(cornerRadius: 5)
            .fill(color)
            .frame(width: barWidth,
                   height: (percent / ceiling) * barHeight)
        } else {
            RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(width: barWidth,
                   height: emptyBarHeight)
        }
    }
}

struct DistributionBar_Previews: PreviewProvider {
    static var previews: some View {
        DistributionBar_Prevew_View().environmentObject(Colors())
    }
}

struct DistributionBar_Prevew_View: View {
    @EnvironmentObject var colors: Colors
    
    var body: some View {
        HStack(spacing: 1) {
            DistributionBar(colors.getActiveColor(range: .low), 4, 5)
            DistributionBar(colors.getActiveColor(range: .mid), 4, 5)
            DistributionBar(colors.getActiveColor(range: .high), 0.34, 15)
            DistributionBar(colors.getActiveColor(range: .high), 0.29, 15)
        }
    }
}
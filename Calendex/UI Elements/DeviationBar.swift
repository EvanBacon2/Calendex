//
//  DeviationBar.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationBar: View {
    var percent: CGFloat
    var ceiling: CGFloat
    var color: Color
    var barWidth = Dimensions.BASE_UNIT * 5
    var barHeight = Dimensions.BASE_UNIT * 50
    var emptyBarHeight = Dimensions.BASE_UNIT * 3
    
    init(_ color: Color,_ percent: CGFloat, _ ceiling: CGFloat) {
        self.color = color
        self.percent = percent
        self.ceiling = ceiling
    }
    
    var body: some View {
        if (percent > 0.3) {
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

struct DeviationBar_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 1) {
            DeviationBar(AppColors.LOW_2, 4, 5)
            DeviationBar(AppColors.MID_2, 4, 5)
            DeviationBar(AppColors.HIGH_2, 0, 5)
        }
    }
}

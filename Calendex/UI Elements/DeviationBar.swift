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
    
    init(_ color: Color,_ percent: CGFloat, _ ceiling: CGFloat) {
        self.color = color
        self.percent = percent
        self.ceiling = ceiling
    }
    
    var body: some View {
        if (percent > 0) {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
            .fill(color)
            .frame(width: UIScreen.screenWidth * 0.02,
                   height: (percent / ceiling) * UIScreen.screenHeight * 0.1)
        } else {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
            .fill(color)
            .frame(width: UIScreen.screenWidth * 0.02,
                   height: UIScreen.screenWidth * 0.01)
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

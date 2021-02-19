//
//  DataBar.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct DataBar: View {
    var barWidth: CGFloat
    var barHeight: CGFloat
    
    init() {
        self.barWidth = UIScreen.screenWidth * 0.85 - UIScreen.screenHeight * 0.023
        self.barHeight = UIScreen.screenHeight * 0.0115
    }
    
    var body: some View {
        HStack(spacing: 0) {
            barCap(endCap: false)
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: barWidth,
                       height: barHeight)
            barCap(endCap: true)
        }
    }
    
    func barCap(endCap: Bool) -> some View {
        return HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: barHeight)
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: barHeight,
                       height: barHeight)
                .offset(x: barHeight / 2)
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: barHeight / 2,
                       height: barHeight)
        }.frame(height: barHeight)
         .rotationEffect(.degrees(endCap ? 180 : 0))
    }
}

struct DataBar_Previews: PreviewProvider {
    static var previews: some View {
        DataBar()
    }
}

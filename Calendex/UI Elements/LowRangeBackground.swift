//
//  RangeBackground.swift
//  Calendex
//
//  Created by Evan Bacon on 1/31/21.
//

import SwiftUI

struct LowRangeBackground: View {
    @EnvironmentObject var colors: Colors
    
    var height: CGFloat
    
    init(cutoff: Int) {
        self.height = CGFloat(Double((cutoff - 40)) / 360.0) * 0.4
    }
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(colors.activeColor(range: .low))
                .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * height / 2)
            RoundedRectangle(cornerRadius: UIScreen.screenHeight * 0.0125)
                .fill(colors.activeColor(range: .low))
                .frame(width: UIScreen.screenWidth * 0.8 , height: UIScreen.screenHeight * height)
        }
    }
}

struct LowRangeBackground_Previews: PreviewProvider {
    static var previews: some View {
        LowRangeBackground(cutoff: 70).environmentObject(Colors())
    }
}

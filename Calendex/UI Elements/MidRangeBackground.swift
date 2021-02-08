//
//  MidRangeBackground.swift
//  Calendex
//
//  Created by Evan Bacon on 1/31/21.
//

import SwiftUI

struct MidRangeBackground: View {
    var height: CGFloat
    
    init(lowCutoff: Int, highCutoff: Int) {
        self.height = CGFloat(Double(highCutoff - lowCutoff) / 360.0) * 0.4
    }
    
    var body: some View {
        Rectangle()
            .fill(AppColors.MID_2)
            .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * height)
    }
}

struct MidRangeBackground_Previews: PreviewProvider {
    static var previews: some View {
        MidRangeBackground(lowCutoff: 70, highCutoff: 140)
    }
}

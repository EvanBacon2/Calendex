//
//  MidRangeBackground.swift
//  Calendex
//
//  Created by Evan Bacon on 1/31/21.
//

import SwiftUI

struct MidRangeBackground: View {
    @EnvironmentObject var colors: Colors
    
    var height: CGFloat
    
    init(lowCutoff: Int, highCutoff: Int) {
        self.height = CGFloat(Double(highCutoff - lowCutoff) / 360.0) * 0.4
    }
    
    var body: some View {
        Rectangle()
            .fill(colors.getActiveColor(range: .mid))
            .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * height)
    }
}

struct MidRangeBackground_Previews: PreviewProvider {
    static var previews: some View {
        MidRangeBackground(lowCutoff: 70, highCutoff: 140).environmentObject(Colors())
    }
}

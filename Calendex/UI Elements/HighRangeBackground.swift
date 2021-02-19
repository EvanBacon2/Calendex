//
//  HighRangeBackground.swift
//  Calendex
//
//  Created by Evan Bacon on 1/31/21.
//

import SwiftUI

struct HighRangeBackground: View {
    @EnvironmentObject var colors: Colors
    
    var height: CGFloat
    
    init(cutoff: Int) {
        height = CGFloat(Double(400 - cutoff) / 360.0) * 0.4
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: UIScreen.screenHeight * 0.0125)
                .fill(colors.getActiveColor(range: .high))
                .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * height)
            Rectangle()
                .fill(colors.getActiveColor(range: .high))
                .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * height / 2)
        }
    }
}

struct HighRangeBackground_Previews: PreviewProvider {
    static var previews: some View {
        HighRangeBackground(cutoff: 140).environmentObject(Colors())
    }
}

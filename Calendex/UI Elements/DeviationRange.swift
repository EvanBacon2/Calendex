//
//  DeviationRange.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationRange: View {
    @EnvironmentObject var colors: Colors
    
    let BAR_WIDTH = UIScreen.screenWidth * 0.018
    let values: [CGFloat]
    let length: Int
    let range: Range
    let ceiling: CGFloat
    
    init(_ values: [CGFloat], _ range: Range, _ ceiling: CGFloat? = nil) {
        self.length = values.count
        self.values = values
        self.range = range
        
        if (ceiling != nil) {
            self.ceiling = ceiling!
        } else {
            self.ceiling = 5
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            HStack(alignment: .bottom, spacing: Dimensions.BASE_UNIT) {
                ForEach(0..<length) {i in
                    DeviationBar(colors.getActiveColor(range: range), values[i], ceiling)
                }
            }
            Spacer().frame(height: UIScreen.screenHeight * 0.01)
            RoundedRectangle(cornerRadius: 10)
                .fill(colors.getActiveColor(range: range))
                .frame(width: BAR_WIDTH * CGFloat(length) + ((CGFloat(length) - 1) * UIScreen.screenHeight * 0.002), height: UIScreen.screenHeight * 0.004)
        }.frame(height: UIScreen.screenHeight * 0.114)
    }
}

struct DeviationRange_Previews: PreviewProvider {
    static var previews: some View {
        DeviationRange([1, 1.5, 5], .low).environmentObject(Colors())
    }
}

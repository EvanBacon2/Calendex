//
//  DeviationRange.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationRange: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    let barWidth = UIScreen.screenWidth * 0.016
    var values: [CGFloat]
    let length: CGFloat
    let range: Range
    let ceiling: CGFloat
    
    init(_ values: [CGFloat], _ range: Range, _ ceiling: CGFloat) {
        self.values = values
        self.length = CGFloat(self.values.count)
        self.range = range
        self.ceiling = ceiling < 5.0 ? 5.0 : ceiling
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            HStack(alignment: .bottom, spacing: Dimensions.BASE_UNIT) {
                ForEach(values, id: \.self) {val in
                    DeviationBar(colors.getActiveColor(range: range), val, ceiling)
                }
            }
            Spacer().frame(height: UIScreen.screenHeight * 0.01)
            rangeUnderline()
        }.frame(height: UIScreen.screenHeight * 0.114)
    }
    
    func rangeUnderline() -> some View {
        return RoundedRectangle(cornerRadius: 10)
                    .fill(colors.getActiveColor(range: range))
            .frame(width: barWidth * length + (length - 1) * Dimensions.BASE_UNIT, height: UIScreen.screenHeight * 0.004)
    }
}

struct DeviationRange_Previews: PreviewProvider {
    static let lowVals: [CGFloat] = [1,1,1,1,1,1,1,1]
    static let midVals: [CGFloat] = [1,1,1,1,1,1,1,1]
    
    static var previews: some View {
        HStack() {
            DeviationRange(lowVals, .low, 5.0).environmentObject(Colors())
                  .environmentObject(Goals())
            DeviationRange(midVals, .mid, 5.0).environmentObject(Colors())
                  .environmentObject(Goals())
        }
    }
}

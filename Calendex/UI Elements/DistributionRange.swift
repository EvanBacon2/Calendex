//
//  DistributionRange.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DistributionRange: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    let values: [CGFloat]
    let length: CGFloat
    let range: Range
    let ceiling: CGFloat
    
    let barWidth = UIScreen.screenWidth * 0.016
    let rangeWidth: CGFloat
    
    init(_ values: [CGFloat], _ range: Range, _ ceiling: CGFloat) {
        self.values = values
        self.length = CGFloat(self.values.count)
        self.range = range
        self.ceiling = ceiling < 5.0 ? 5.0 : ceiling
        
        self.rangeWidth = length > 0 ? barWidth * length + (length - 1) * Dimensions.BASE_UNIT : 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            HStack(alignment: .bottom, spacing: Dimensions.BASE_UNIT) {
                ForEach(values, id: \.self) {val in
                    DistributionBar(colors.activeColor(range: range), val, ceiling)
                }
            }
            Spacer().frame(height: UIScreen.screenHeight * 0.01)
            rangeUnderline()
        }.frame(height: UIScreen.screenHeight * 0.114)
    }
    
    func rangeUnderline() -> some View {
        return RoundedRectangle(cornerRadius: 10)
                    .fill(colors.activeColor(range: range))
            .frame(width: rangeWidth, height: UIScreen.screenHeight * 0.004)
    }
}

struct DistributionRange_Previews: PreviewProvider {
    static let lowVals: [CGFloat] = [1,1,1,1,1,1,1,1]
    static let midVals: [CGFloat] = [1,1,1,1,1,1,1,1]
    
    static var previews: some View {
        HStack() {
            DistributionRange(lowVals, .low, 5.0).environmentObject(Colors())
                  .environmentObject(Goals())
            DistributionRange(midVals, .mid, 5.0).environmentObject(Colors())
                  .environmentObject(Goals())
        }
    }
}

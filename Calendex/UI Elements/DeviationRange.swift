//
//  DeviationRange.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationRange: View {
    let BAR_WIDTH = UIScreen.screenWidth * 0.02
    let values: [CGFloat]
    let length: Int
    let color: Color
    let ceiling: CGFloat
    
    init(_ values: [CGFloat], _ range: Range, _ ceiling: CGFloat? = nil) {
        self.length = values.count
        self.values = values
        
        switch range {
        case .low:
            self.color = AppColors.LOW_2
        case .mid:
            self.color = AppColors.MID_2
        case .high:
            self.color = AppColors.HIGH_2
        }
        
        if (ceiling != nil) {
            self.ceiling = ceiling!
        } else {
            self.ceiling = 5
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .bottom, spacing: 1) {
                ForEach(0..<length) {i in
                    DeviationBar(color, values[i], ceiling)
                }
            }
            Rectangle()
                .fill(color)
                .frame(width: BAR_WIDTH * CGFloat(length) + (CGFloat(length) - 1), height: 2)
        }
    }
}

struct DeviationRange_Previews: PreviewProvider {
    static var previews: some View {
        DeviationRange([1, 1.5, 2], .low)
    }
}

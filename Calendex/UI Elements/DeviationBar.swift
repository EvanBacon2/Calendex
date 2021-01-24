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
    
    init(_ range: Range,_ percent: CGFloat, _ ceiling: CGFloat? = nil) {
        self.percent = percent
        
        if ((ceiling) != nil) {
            self.ceiling = ceiling!
        } else {
            self.ceiling = 5
        }
        
        switch range {
        case .low:
            self.color = AppColors.LOW_2
        case .mid:
            self.color = AppColors.MID_2
        case .high:
            self.color = AppColors.HIGH_2
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5, style: .continuous)
            .fill(color)
            .frame(width: UIScreen.screenWidth * 0.025,
                   height: (percent / ceiling) * UIScreen.screenHeight * 0.1)
    }
}

struct DeviationBar_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 1) {
            DeviationBar(.low, 4)
            DeviationBar(.mid, 4)
            DeviationBar(.high, 4)
        }
    }
}

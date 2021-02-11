//
//  DeviationRangeMarker.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationRangeMarker: View {
    var val: String
    
    init(_ val: String) {
        self.val = val
    }
    
    var body: some View {
        VStack(spacing: 3) {
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(AppColors.LIGHT_BLUE_GRAY)
                    .frame(width: UIScreen.screenHeight * 0.004, height: UIScreen.screenHeight * 0.024)
            }.frame(height: UIScreen.screenHeight * 0.126)
            Text(val)
                .font(.system(size: 15))
                .fixedSize()
                .frame(width: 4)
        }
    }
}

struct DeviationRangeMarker_Previews: PreviewProvider {
    static var previews: some View {
        DeviationRangeMarker("70")
    }
}

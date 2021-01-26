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
        VStack() {
            Spacer()
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: 2, height: 12)
                .offset(y: 40)
            Text(val)
                .fixedSize()
                .frame(width: 4)
                .offset(y: 35)
        }.frame(height: UIScreen.screenHeight * 0.1 + 7)
    }
}

struct DeviationRangeMarker_Previews: PreviewProvider {
    static var previews: some View {
        DeviationRangeMarker("70")
    }
}

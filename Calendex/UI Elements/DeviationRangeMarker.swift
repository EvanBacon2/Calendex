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
                .offset(y: 30)
            Text(val)
                .font(.system(size: 15))
                .fixedSize()
                .frame(width: 4)
                .offset(y: 25)
        }.frame(height: UIScreen.screenHeight * 0.1 + 7)
    }
}

struct DeviationRangeMarker_Previews: PreviewProvider {
    static var previews: some View {
        DeviationRangeMarker("70")
    }
}

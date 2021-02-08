//
//  DOWBanner.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DowBanner: View {
    var dows = ["S", "M", "T", "W", "Th", "F", "S"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack() {
                Spacer()
                ForEach(0..<7) { i in
                    Text(dows[i])
                        .fixedSize()
                        .frame(width: UIScreen.screenWidth * 0.9 / 9)
                    Spacer()
                }
            }
            Rectangle()
                .fill(AppColors.DARK_GRAY)
                .frame(width: UIScreen.screenWidth * 0.9, height: 1)
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DowBanner_Previews: PreviewProvider {
    static var previews: some View {
        DowBanner()
    }
}

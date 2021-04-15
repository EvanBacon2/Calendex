//
//  DistributionYAxis.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import SwiftUI

struct DistributionYAxis: View {
    let ceiling: CGFloat
    
    init(ceiling: CGFloat) {
        self.ceiling = ceiling
    }
    
    var body: some View {
        VStack() {
            Text("\(Int(round(ceiling)))")
                .font(.footnote)
                .foregroundColor(AppColors.DARK_GRAY)
            Spacer()
            Text("0")
                .font(.footnote)
                .foregroundColor(AppColors.DARK_GRAY)
        }.frame(height: UIScreen.screenHeight * 0.1)
        VStack() {
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: UIScreen.screenHeight * 0.004,
                       height: UIScreen.screenHeight * 0.1)
                Spacer()
        }.frame(height: UIScreen.screenHeight * 0.114)
    }
}

struct DistributionYAxis_Previews: PreviewProvider {
    static var previews: some View {
        DistributionYAxis(ceiling: 5.0)
    }
}

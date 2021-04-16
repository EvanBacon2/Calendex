//
//  DistributionYAxis.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import SwiftUI

struct DistributionYAxis: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    let ceiling: CGFloat
    
    init(ceiling: CGFloat) {
        self.ceiling = ceiling
    }
    
    var body: some View {
        VStack() {
            Text("\(Int(round(ceiling)))")
                .font(.footnote)
                .foregroundColor(colors.fillerTextColor(colorScheme))
            Spacer()
            Text("0")
                .font(.footnote)
                .foregroundColor(colors.fillerTextColor(colorScheme))
        }.frame(height: UIScreen.screenHeight * 0.1)
        VStack() {
            Rectangle()
                .fill(colors.fillerButtonColor(colorScheme))
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

//
//  DistributionRangeMarker.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DistributionRangeMarker: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    let val: String
    let angleOffset: Double
    let angleShift: Double
    
    let markerW = UIScreen.screenHeight * 0.004
    let markerH = UIScreen.screenHeight * 0.018
    
    init(_ val: String, angleOffset: Double) {
        self.val = val
        self.angleOffset = angleOffset
        self.angleShift = -sin(angleOffset) * Double(markerH) / 1.8
    }
    
    var body: some View {
        VStack(spacing: 3) {
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .fill(colors.fillerButtonColor(colorScheme))
                    .frame(width: markerW, height: markerH)
                    .rotationEffect(.radians(angleOffset))
                    .offset(x: CGFloat(angleShift))
            }.frame(height: UIScreen.screenHeight * 0.134)
            Text(val)
                .font(.title3)
                .fixedSize()
                .frame(width: 4)
                .offset(x: CGFloat(angleShift))
        }
    }
}

struct DistributionRangeMarker_Previews: PreviewProvider {
    static var previews: some View {
        DistributionRangeMarker("70", angleOffset: Double.pi / 4.0)
            .environmentObject(Colors())
    }
}

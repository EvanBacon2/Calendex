//
//  TimeBar.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct TimeBar: View {
    var lowPerc: CGFloat
    var lowWidth: CGFloat
    var midPerc: CGFloat
    var midWidth: CGFloat
    var highPerc: CGFloat
    var highWidth: CGFloat
    
    let lowText: String
    let midText: String
    let highText: String
    
    init(low: CGFloat, mid: CGFloat, high: CGFloat) {
        self.lowPerc = low
        self.lowWidth = low * 250 < 20 ? 0 :
                        low == 1 ? 210 : low * 250 - 20
        self.midPerc = mid
        self.midWidth = mid * 250 < 20 ? 20 :
                        mid == 1 ? 210 : mid * 250 - 40
        self.highPerc = high
        self.highWidth = high * 250 < 20 ? 0 :
                         high == 1 ? 210 : high * 250 - 20
        
        self.lowText = "$\(lowPerc * 100)%"
        self.midText = "$\((1 - (lowPerc + highPerc)) * 100)%"
        self.highText = "$\(highPerc * 100)%"
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack() {
                HStack(spacing: 0) {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(lowPerc > 0 ? AppColors.LOW_2 :
                              highPerc == 1 ? AppColors.HIGH_2 : AppColors.MID_2)
                        .rotationEffect(.degrees(90))
                        .frame(width: 40, height: 40)
                        .frame(width: 20)
                        .offset(x: 10)
                    
                    Rectangle()
                        .fill(AppColors.LOW_2)
                        .frame(width: lowWidth, height: 40)
                }
                if (lowPerc > 0) {
                    Text("12%")
                        .fixedSize()
                        .frame(width: 20)
                }
            }
            if (lowPerc > 0) {
                Spacer().frame(width: 4)
            }
            VStack() {
                Rectangle()
                    .fill(AppColors.MID_2)
                    .frame(width: midWidth, height: 40)
                if (lowPerc + highPerc < 1) {
                    Text("80%")
                        .fixedSize()
                        .frame(width: 20)
                }
            }
            if (highPerc > 0) {
                Spacer().frame(width: 4)
            }
            Rectangle()
                .fill(AppColors.HIGH_2)
                .frame(width: highWidth, height: 40)
                
            
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(highPerc > 0 ? AppColors.HIGH_2 :
                      lowPerc == 1 ? AppColors.LOW_2 : AppColors.MID_2)
                .rotationEffect(.degrees(-90))
                .frame(width: 40, height: 40)
                .frame(width: 20)
                .offset(x: -10)
        }
    }
}

struct TimeBar_Previews: PreviewProvider {
    static var previews: some View {
        TimeBar(low: 0.0, mid: 0.0, high: 0.9)
    }
}

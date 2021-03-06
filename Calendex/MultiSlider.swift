//
//  GoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/6/21.
//

import SwiftUI

struct MultiSlider: View {
    @State private var limits: [CGFloat]
    
    var dragLimit: CGFloat = UIScreen.screenWidth * (0.425) - UIScreen.screenHeight * 0.0115
    let multiThumb: Bool
    var thumbOneColor: Color
    
    init(multiThumb: Bool) {
        self.multiThumb = multiThumb
        
        if (multiThumb) {
            thumbOneColor = AppColors.LOW_2
            _limits = State(initialValue: [-dragLimit, -20.0, 20.0, dragLimit])
        } else {
            thumbOneColor = AppColors.MID_2
            _limits = State(initialValue: [-dragLimit, 0.0, dragLimit])
        }
    }
    
    var body: some View {
        ZStack() {
            HStack(spacing: 0) {
                Spacer().frame(width: 10)
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColors.LOW_2)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                Rectangle()
                    .fill(AppColors.LOW_2)
                    .frame(width: UIScreen.screenWidth * (0.425 - 0.0115) + limits[1],
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                if (multiThumb) {
                    Rectangle()
                        .fill(AppColors.MID_2)
                        .frame(width: limits[2] - limits[1],
                               height: UIScreen.screenHeight * 0.0115)
                        .offset(x: -5)
                }
                Rectangle()
                    .fill(AppColors.HIGH_2)
                    .frame(width: UIScreen.screenWidth * (0.425 - 0.0115) - limits[2],
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColors.HIGH_2)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -10)
            }
            ForEach(1..<limits.count - 1) { i in
                SliderThumb(pos: i, limits: $limits)
            }
        }
    }
}

struct MultiSlider_Previews: PreviewProvider {
    static var previews: some View {
        MultiSlider(multiThumb: true)
    }
}

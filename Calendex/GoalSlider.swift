//
//  GoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/11/21.
//

import SwiftUI

enum Metric {
    case RANGE
    case TIME
    case DEVIATION
}

struct GoalSlider: View {
    @EnvironmentObject var goals: Goals
    
    @State private var limits: [CGFloat]
    
    var metric: Metric
    var dragLimit: CGFloat = UIScreen.screenWidth * (0.425) - UIScreen.screenHeight * 0.0115
    var thumbOneColor: Color
    
    init(metric: Metric) {
        self.metric = metric
        
        switch metric {
        case .RANGE:
            thumbOneColor = AppColors.LOW_2
            
            var lowThumb = (UIScreenWidth * 0.85 * ((goals.lowBgThreshold - 60) / 340)) - UIScreen.screenWidth * 0.425
            var highThumb = (UIScreenWidth * 0.85 * ((goals.highBgThreshold - 60) / 340)) - UIScreen.screenWidth * 0.425
            
            _limits = State(initialValue: [-dragLimit, lowThumb, highThumb, dragLimit])
        case .TIME:
            thumbOneColor = AppColors.MID_2
            _limits = State(initialValue: [-dragLimit, 0.0, dragLimit])
        case .DEVIATION:
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
                if (metric == .RANGE) {
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

struct GoalSlider_Previews: PreviewProvider {
    static var previews: some View {
        GoalSlider(metric: .RANGE)
    }
}

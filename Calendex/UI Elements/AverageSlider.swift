//
//  AverageSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct AverageSlider: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Low/High Boundries").font(.title3)
            Spacer().frame(height: UIScreen.screenHeight * 0.015)
            SliderRuler(markings: [60, 100, 200, 300, 400])
            Spacer().frame(height: UIScreen.screenHeight * 0.05)
            GoalSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, metric: Average(goals: _goals))
        }
    }
}

struct AverageSlider_Previews: PreviewProvider {
    static var previews: some View {
        AverageSlider().environmentObject(Goals())
                       .environmentObject(Colors())
    }
}

//
//  DeviationSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct DeviationSlider: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Standard Deviation")
            Spacer().frame(height: UIScreen.screenHeight * 0.015)
            SliderRuler(markings: [0, 25, 50, 75, 100])
            Spacer().frame(height: UIScreen.screenHeight * 0.03)
            GoalSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, metric: Deviation(goals: _goals))
        }
    }
}

struct DeviationSlider_Previews: PreviewProvider {
    static var previews: some View {
        DeviationSlider().environmentObject(Goals())
                         .environmentObject(Colors())
    }
}


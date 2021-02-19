//
//  TimeSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct TimeSlider: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Time In Range")
            Spacer().frame(height: UIScreen.screenHeight * 0.015)
            SliderRuler(markings: [0, 25, 50, 75, 100])
            Spacer().frame(height: UIScreen.screenHeight * 0.03)
            GoalSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, metric: Time(goals: _goals))
        }
    }
}

struct TimeSlider_Previews: PreviewProvider {
    static var previews: some View {
        TimeSlider().environmentObject(Goals())
    }
}

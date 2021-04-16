//
//  NewGoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 4/16/21.
//

import SwiftUI

struct NewGoalSlider: View {
    @EnvironmentObject var colors: Colors
    
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    let metric: Metric
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, metric: Metric) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.metric = metric
    }
    
    var body: some View {
        MultiSlider(sliderWidth: sliderWidth, sliderHeight: sliderHeight,
                    range: metric.valueRange, step: metric.step,
                    thumbPadding: metric.thumbPadding,
                    values: metric.getMetrics(),
                    valueColors: metric.activeRanges.map { colors.activeColor(range: $0)})
    }
}

struct NewGoalSlider_Previews: PreviewProvider {
    static var previews: some View {
        //NewGoalSlider()
        EmptyView()
    }
}

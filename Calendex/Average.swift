//
//  Average.swift
//  Calendex
//
//  Created by Evan Bacon on 2/14/21.
//

import SwiftUI

struct Average: View, Metric {
    @EnvironmentObject var goals: Goals
    
    //Slider Fields
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Thumb Fields
    let thumbAdjustment: CGFloat
    let thumbPadding: CGFloat
    let dragLimit: CGFloat
    
    //Range Fields
    let rangeStart: Int
    let rangeEnd: Int
    
    //Color Fields
    var lowColor: Color
    var midColor: Color
    var highColor: Color
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, dragLimit: CGFloat) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.thumbAdjustment = sliderWidth / 2
        self.thumbPadding = 10
        self.dragLimit  = dragLimit
        
        self.rangeStart = 60
        self.rangeEnd = 400
        
        self.lowColor = AppColors.LOW_2
        self.midColor = AppColors.MID_2
        self.highColor = AppColors.HIGH_2
    }
    
    var body: some View { getSlider() }
    
    func getSlider() -> some View {
        let lowWidth = calcWidth(range: .low)
        let midWidth = calcWidth(range: .mid)
        let highWidth = calcWidth(range: .high)
        
        return ZStack() {
            HStack(spacing: 0) {
                getBar(range: .low, width: lowWidth)
                getBar(range: .mid, width: midWidth)
                getBar(range: .high, width: highWidth)
            }
            HStack(spacing: 0) {
                getThumb(startPos: lowWidth - thumbAdjustment,
                         lowThreshold: -dragLimit,
                         highThreshold: (lowWidth + midWidth - thumbAdjustment) - 10,
                         val: Binding(get: { return goals.lowBgThreshold },
                            set: { (newValue) in goals.lowBgThreshold = newValue }))
                getThumb(startPos: lowWidth - thumbAdjustment,
                         lowThreshold: -dragLimit,
                         highThreshold: (lowWidth + midWidth - thumbAdjustment) - 10,
                         val: Binding(get: { return goals.highBgThreshold },
                            set: { (newValue) in goals.highBgThreshold = newValue }))
            }
        }
    }
    
    func getBar(range: Range, width: CGFloat) -> AnyView {
        let startCap = range == .low
        let endCap = range == .high
        
        return AnyView(HStack(spacing: 0) {
            if (startCap) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
            }
            Rectangle()
                .fill(barColor(range: range))
                .frame(width: width,
                       height: sliderHeight)
                .offset(x: -5)
            if (endCap) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
                    .offset(x: -10)
            }
        })
    }
    
    func getThumb(startPos: CGFloat, lowThreshold: CGFloat, highThreshold: CGFloat, val: Binding<Int>) -> AnyView {
        return AnyView(SliderThumb(startPos: startPos, lowThreshold: lowThreshold, highThreshold: highThreshold, updateGoal: val))
    }
    
    func barColor(range: Range) -> Color {
        switch range {
        case .low:
            return self.lowColor
        case .mid:
            return self.midColor
        case .high:
            return self.highColor
        }
    }
    
    func calcWidth(range: Range) -> CGFloat {
        return convertMetricToWidth(val: getMetricVal(range: range))
    }
    
    func convertMetricToWidth(val: Int) -> CGFloat {
        return CGFloat((val - rangeStart)) / CGFloat(rangeStart - rangeEnd) * sliderWidth
    }
    
    func convertWidthToMetric(width: CGFloat) -> Int {
        return Int(width * CGFloat(rangeStart - rangeEnd) / sliderWidth + CGFloat(rangeStart))
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
        case .low:
            return goals.lowBgThreshold
        case .mid:
            return goals.highBgThreshold - goals.lowBgThreshold + rangeStart
        case .high:
            return (rangeStart + rangeEnd) - goals.highBgThreshold
        }
    }
}

struct Average_Previews: PreviewProvider {
    static var previews: some View {
        Average(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, dragLimit: UIScreen.screenWidth * 0.425 - UIScreen.screenHeight * 0.0115).environmentObject(Goals())
    }
}

//
//  TimeSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/16/21.
//

import SwiftUI

struct TimeSlider: View {
    @EnvironmentObject var goals: Goals
    
    //Slider Fields
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Thumb Fields
    let dragLimit: CGFloat
    let thumbAdjustment: CGFloat
    
    //Range Fields
    let rangeStart: Int
    let rangeEnd: Int
    
    //Color Fields
    var lowColor: Color
    var midColor: Color
    var highColor: Color
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat) {
        self.sliderWidth = sliderWidth - (sliderHeight * 2)
        self.sliderHeight = sliderHeight
        
        self.dragLimit = self.sliderWidth / 2
        self.thumbAdjustment = dragLimit
        
        self.rangeStart = 0
        self.rangeEnd = 100
        
        self.lowColor = AppColors.LOW_2
        self.midColor = AppColors.MID_2
        self.highColor = AppColors.HIGH_2
    }
    
    var body: some View { getSlider() }
    
    func getSlider() -> some View {
        let midWidth = calcWidth(range: .mid)
        let highWidth = calcWidth(range: .high)
        
        return ZStack() {
            HStack(spacing: 0) {
                getBar(range: .mid, width: midWidth)
                getBar(range: .high, width: highWidth)
            }
            HStack(spacing: 0) {
                getThumb(startPos: Binding(get: { return convertMetricToWidth(val: goals.TimeInRangeThreshold) - thumbAdjustment                       }, set: {_,_ in }),
                         lowThreshold: -dragLimit,
                         highThreshold: dragLimit,
                         val: Binding(get: { return 0.0},
                                      set: { (newValue) in goals.TimeInRangeThreshold = convertWidthToMetric(width: newValue)}))
            }
            Text("\(goals.TimeInRangeThreshold)")
        }
    }
    
    func getBar(range: Range, width: CGFloat) -> some View {
        let startCap = range == .mid
        let endCap = range == .high
        
        return AnyView(HStack(spacing: 0) {
            if (startCap) {
                RoundedRectangle(cornerRadius: sliderHeight)
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
                    .offset(x: sliderHeight / 2)
                Rectangle()
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight / 2,
                           height: sliderHeight)
            }
            Rectangle()
                .fill(barColor(range: range))
                .frame(width: width,
                       height: sliderHeight)
            if (endCap) {
                Rectangle()
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight / 2,
                           height: sliderHeight)
                RoundedRectangle(cornerRadius: sliderHeight)
                    .fill(barColor(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
                    .offset(x: -sliderHeight / 2)
            }
        })
    }
    
    func getThumb(startPos: Binding<CGFloat>, lowThreshold: CGFloat, highThreshold: CGFloat, val: Binding<CGFloat>) -> some View {
        return AnyView(SliderThumb(startPos: startPos, lowThreshold: lowThreshold, highThreshold: highThreshold, val: val))
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
        return CGFloat((val - rangeStart)) / CGFloat(rangeEnd - rangeStart) * sliderWidth
    }
    
    func convertWidthToMetric(width: CGFloat) -> Int {
        return Int(round((width + thumbAdjustment) *     CGFloat(rangeEnd - rangeStart) / sliderWidth + CGFloat(rangeStart)))
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
        case .low:
            return goals.TimeInRangeThreshold
        case .mid:
            return goals.TimeInRangeThreshold
        case .high:
            return rangeEnd - goals.TimeInRangeThreshold
        }
    }
}

struct TimeSlider_Previews: PreviewProvider {
    static var previews: some View {
        TimeSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115).environmentObject(Goals())
    }
}

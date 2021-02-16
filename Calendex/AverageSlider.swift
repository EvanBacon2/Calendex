//
//  Average.swift
//  Calendex
//
//  Created by Evan Bacon on 2/14/21.
//

import SwiftUI

struct AverageSlider: View {
    @EnvironmentObject var goals: Goals
    
    //Slider Fields
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Thumb Fields
    let thumbAdjustment: CGFloat
    let thumbPadding: Int
    let dragLimit: CGFloat
    
    //Range Fields
    let rangeStart: Int
    let rangeEnd: Int
    
    //Color Fields
    var lowColor: Color
    var midColor: Color
    var highColor: Color
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, thumbPadding: Int) {
        self.sliderWidth = sliderWidth - (sliderHeight * 2)
        self.sliderHeight = sliderHeight
        
        self.dragLimit  = self.sliderWidth / 2
        self.thumbAdjustment = dragLimit
        self.thumbPadding = thumbPadding + 60
        
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
        
        let thumbPaddingWidth = convertMetricToWidth(val: thumbPadding)
        
        let lowMetricBinding = Binding(get: { return goals.lowBgThreshold}, set: { (newValue) in goals.lowBgThreshold = newValue })
        
        let lowPositionBinding = Binding(get: { return convertMetricToWidth(val: lowMetricBinding.wrappedValue) - thumbAdjustment }, set: {_,_ in })
        
        let lowValBinding = Binding(get: { return 0.0 }, set: { (newValue) in lowMetricBinding.wrappedValue = convertWidthToMetric(width: newValue) })
        
        return ZStack() {
            HStack(spacing: 0) {
                getBar(range: .low, width: lowWidth)
                getBar(range: .mid, width: midWidth)
                getBar(range: .high, width: highWidth)
            }
            HStack(spacing: 0) {
                getThumb(startPos: lowPositionBinding,
                         lowThreshold: -dragLimit,
                         highThreshold: (lowWidth + midWidth - thumbAdjustment) - thumbPaddingWidth,
                         val: lowValBinding)
                getThumb(startPos: Binding(get: { return convertMetricToWidth(val: goals.highBgThreshold) - thumbAdjustment }, set: {_,_ in }),
                         lowThreshold: (lowWidth - thumbAdjustment) + thumbPaddingWidth,
                         highThreshold: dragLimit,
                         val: Binding(get: { return 0.0 }, set: { (newValue) in goals.highBgThreshold = convertWidthToMetric(width: newValue) }))
            }
            VStack() {
            Text("\(goals.lowBgThreshold)")
            Text("\(goals.highBgThreshold)")
            }
        }
    }
    
    func getBar(range: Range, width: CGFloat) -> some View {
        let startCap = range == .low
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
        return CGFloat((val - rangeStart)) / CGFloat(rangeEnd - rangeStart) * sliderWidth
    }
    
    func convertWidthToMetric(width: CGFloat) -> Int {
        return Int(round((width + thumbAdjustment) * CGFloat(rangeEnd - rangeStart) / sliderWidth + CGFloat(rangeStart)))
    }
    
    func getMetricVal(range: Range) -> Int {
        switch range {
        case .low:
            return goals.lowBgThreshold
        case .mid:
            return (goals.highBgThreshold - goals.lowBgThreshold) + rangeStart
        case .high:
            return (rangeStart + rangeEnd) - goals.highBgThreshold
        }
    }
}

struct Average_Previews: PreviewProvider {
    static var previews: some View {
        AverageSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, thumbPadding: 10)
            .environmentObject(Goals())
    }
}

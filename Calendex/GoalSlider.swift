//
//  GoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/11/21.
//

import SwiftUI

struct GoalSlider: View {
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
    let activeRanges: Array<Range>
    
    let metrics: Array<Binding<Int>>
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, valueRange: ClosedRange<Int> = 0...100, thumbPadding: Int, activeRanges: Array<Range>, metrics: Array<Binding<Int>>) {
        
        self.sliderWidth = sliderWidth - (sliderHeight * 2)
        self.sliderHeight = sliderHeight
        
        self.dragLimit = self.sliderWidth / 2
        self.thumbAdjustment = dragLimit
        
        self.rangeStart = valueRange.lowerBound
        self.rangeEnd = valueRange.upperBound
        self.activeRanges = activeRanges
        
        self.thumbPadding = thumbPadding + rangeStart
        
        self.metrics = metrics
    }
    
    var body: some View { getSlider() }
    
    func getSlider() -> some View {
        let thumbPaddingWidth = convertMetricToWidth(val: thumbPadding)
        
        return ZStack() {
            HStack(spacing: 0) {
                ForEach(0..<activeRanges.count) { [self] i in
                    getBar(range: activeRanges[i], width: calcWidth(range: activeRanges[i]))
                }
            }
            HStack(spacing: 0) {
                ForEach(0..<activeRanges.count - 1) { [self] i in
                    getThumb(startPos: getPositionBinding(binding: metrics[i]),
                             lowThreshold: i == 0 ? -dragLimit : calcThumbPos(rangeInd: i - 1) + thumbPaddingWidth,
                             highThreshold: i == activeRanges.count - 2 ? dragLimit : calcThumbPos(rangeInd: i + 1) - thumbPaddingWidth,
                             val: getValueBinding(binding: metrics[i]))
                }
            }
        }
    }
    
    func getPositionBinding(binding: Binding<Int>) -> Binding<CGFloat> {
        return Binding(get: { return self.convertMetricToWidth(val: binding.wrappedValue) - self.thumbAdjustment }, set: {_,_ in })
    }
    
    func getValueBinding(binding: Binding<Int>) -> Binding<CGFloat> {
        return Binding(get: { return 0.0 }, set: { (newValue) in binding.wrappedValue = self.convertWidthToMetric(width: newValue) })
    }
    
    func calcThumbPos(rangeInd: Int) -> CGFloat {
        return activeRanges[0...rangeInd].reduce(0, { x, y in x + calcWidth(range: y) }) - thumbAdjustment
    }
    
    func getBar(range: Range, width: CGFloat) -> some View {
        return AnyView(HStack(spacing: 0) {
            if (range == activeRanges[0]) {
                RoundedRectangle(cornerRadius: sliderHeight)
                    .fill(AppColors.getColorForRange(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
                    .offset(x: sliderHeight / 2)
                Rectangle()
                    .fill(AppColors.getColorForRange(range: range))
                    .frame(width: sliderHeight / 2,
                           height: sliderHeight)
            }
            Rectangle()
                .fill(AppColors.getColorForRange(range: range))
                .frame(width: width,
                       height: sliderHeight)
            if (range == activeRanges[activeRanges.count - 1]) {
                Rectangle()
                    .fill(AppColors.getColorForRange(range: range))
                    .frame(width: sliderHeight / 2,
                           height: sliderHeight)
                RoundedRectangle(cornerRadius: sliderHeight)
                    .fill(AppColors.getColorForRange(range: range))
                    .frame(width: sliderHeight,
                           height: sliderHeight)
                    .offset(x: -sliderHeight / 2)
            }
        })
    }
    
    func getThumb(startPos: Binding<CGFloat>, lowThreshold: CGFloat, highThreshold: CGFloat, val: Binding<CGFloat>) -> some View {
        return SliderThumb(startPos: startPos, lowThreshold: lowThreshold, highThreshold: highThreshold, updateGoal: val)
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

struct GoalSlider_Previews: PreviewProvider {
    static var previews: some View {
        GoalSlider_Preview_Provider().environmentObject(Goals())
    }
}

struct GoalSlider_Preview_Provider: View {
    @EnvironmentObject var goals: Goals
    
    var body: some View {
        GoalSlider(sliderWidth: UIScreen.screenWidth * 0.85, sliderHeight: UIScreen.screenHeight * 0.0115, valueRange: 60...400, thumbPadding: 10, activeRanges: [.low, .mid, .high], metrics: [$goals.lowBgThreshold, $goals.highBgThreshold])
    }
}

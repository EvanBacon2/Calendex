//
//  GoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/11/21.
//

import SwiftUI

struct GoalSlider: View {
    @EnvironmentObject var colors: Colors
    
    @State var fakeMetricVals: [Int]
    
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
    
    //Slider Metric
    let metric: Metric
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, metric: Metric) {
        self.sliderWidth = sliderWidth - (sliderHeight * 2)
        self.sliderHeight = sliderHeight
        
        self.metric = metric
        self._fakeMetricVals = State(wrappedValue: metric.getMetrics().map { $0.wrappedValue })
        
        self.dragLimit = self.sliderWidth / 2
        self.thumbAdjustment = dragLimit
        
        self.rangeStart = metric.valueRange.lowerBound
        self.rangeEnd = metric.valueRange.upperBound
        self.activeRanges = metric.activeRanges
        
        self.thumbPadding = metric.thumbPadding + rangeStart
    }
    
    var body: some View { getSlider() }
    
    func getSlider() -> some View {
        let thumbPaddingWidth = convertMetricToWidth(val: thumbPadding)
        
        return ZStack() {
            HStack(spacing: 0) {
                ForEach(0..<metric.activeRanges.count) { [self] i in
                    getBar(range: metric.activeRanges[i], width: calcWidth(range: metric.activeRanges[i]))
                }
            }
            ZStack() {
                ForEach(0..<metric.activeRanges.count - 1) { [self] i in
                    SliderThumb(startPos: getFakePosBinding(i),
                                lowThreshold: i == 0 ? -dragLimit : thumbPosition(index: i - 1) + thumbPaddingWidth,
                                highThreshold: i == metric.activeRanges.count - 2 ? dragLimit : thumbPosition(index: i + 1) - thumbPaddingWidth,
                                val: getFakeValBinding(i),
                                realVal: getValueBinding(binding: metric.getMetrics()[i]), textOnTop: i % 2 == 0)
                }
            }
        }
    }
    
    func getValueBinding(binding: Binding<Int>) -> Binding<CGFloat> {
        return Binding(get: { return CGFloat(binding.wrappedValue) },
                       set: { (newValue) in binding.wrappedValue = self.convertWidthToMetric(width: newValue) })
    }
    
    func getFakePosBinding(_ i: Int) -> Binding<CGFloat> {
        return Binding(get: { return self.convertMetricToWidth(val: fakeMetricVals[i]) - self.thumbAdjustment },
                       set: {_ in })
    }
    
    func getFakeValBinding(_ i: Int) -> Binding<CGFloat> {
        return Binding(get: { return CGFloat(fakeMetricVals[i]) },
                       set: { newVal in fakeMetricVals[i] = self.convertWidthToMetric(width: newVal) })
    }
    
    func thumbPosition(index: Int) -> CGFloat {
        return getFakePosBinding(index).wrappedValue
    }
    
    func getBar(range: Range, width: CGFloat) -> some View {
        return HStack(spacing: 0) {
            if (range == activeRanges[0]) {
                barCap(range: range, endCap: false)
            }
            Rectangle()
                .fill(colors.activeColor(range: range))
                .frame(width: width,
                       height: sliderHeight)
            if (range == activeRanges[activeRanges.count - 1]) {
                barCap(range: range, endCap: true)
            }
        }
    }
    
    func barCap(range: Range, endCap: Bool) -> some View {
        return HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: sliderHeight)
                .fill(colors.activeColor(range: range))
                .frame(width: sliderHeight,
                       height: sliderHeight)
                .offset(x: sliderHeight / 2)
            Rectangle()
                .fill(colors.activeColor(range: range))
                .frame(width: sliderHeight / 2,
                       height: sliderHeight)
        }.frame(height: sliderHeight)
         .rotationEffect(.degrees(endCap ? 180 : 0))
    }
    
    func calcWidth(range: Range) -> CGFloat {
        return convertMetricToWidth(val: metric.getMetricVal(range: range, vals: fakeMetricVals))
    }
    
    func convertMetricToWidth(val: Int) -> CGFloat {
        return CGFloat((val - rangeStart)) / CGFloat(rangeEnd - rangeStart) * sliderWidth
    }
    
    func convertWidthToMetric(width: CGFloat) -> Int {
        let wholeNum = Int(round((width + thumbAdjustment) * CGFloat(rangeEnd - rangeStart) / sliderWidth + CGFloat(rangeStart)))
        
        return wholeNum - wholeNum % metric.step
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
        GoalSlider(sliderWidth: UIScreen.screenWidth * 0.85,
                   sliderHeight: UIScreen.screenHeight * 0.0115,
                   metric: Average(goals: _goals)).environmentObject(Colors())
    }
}

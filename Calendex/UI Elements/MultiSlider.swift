//
//  MultiSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 4/16/21.
//

import SwiftUI

struct MultiSlider: View {
    //Val Fields
    @State private var fakeValues: [Int]
    private var values: [Binding<Int>]
    
    //Slider Fields
    private let sliderWidth: CGFloat
    private let sliderHeight: CGFloat
    private let sections: Int
    
    //Thumb Fields
    private let step: Int
    private let dragLimit: CGFloat
    private let thumbAdjustment: CGFloat
    private let thumbPadding: Int
    
    //Range Fields
    private let rangeStart: Int
    private let rangeEnd: Int
    
    //StyleFields
    private let valueColors: [Color]
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, range: ClosedRange<Int> = 1...100, step: Int = 1, thumbPadding: Int = 10,     values: [Binding<Int>], valueColors: [Color] = [Color.white, Color.white, Color.white]) {
        self._fakeValues = State(wrappedValue: values.map { $0.wrappedValue })
        self.values = values
        
        self.sliderWidth = sliderWidth - (sliderHeight * 2)
        self.sliderHeight = sliderHeight
        self.sections = valueColors.count
        
        self.step = step
        self.dragLimit = self.sliderWidth / 2
        self.thumbAdjustment = dragLimit
        self.thumbPadding = thumbPadding + range.lowerBound
        
        self.rangeStart = range.lowerBound
        self.rangeEnd = range.upperBound
        
        self.valueColors = valueColors
    }
    
    var body: some View { getSlider() }
    
    func getSlider() -> some View {
        let thumbPaddingWidth = valueToWidth(thumbPadding)
        
        return ZStack() {
            HStack(spacing: 0) {
                ForEach(0..<sections) { [self] i in
                    getSection(section: i)
                }
            }
            ZStack() {
                ForEach(0..<values.count) { [self] i in
                    SliderThumb(startPos: getFakePosBinding(i),
                                lowThreshold: i == 0 ? -dragLimit : thumbPosition(i - 1) + thumbPaddingWidth,
                                highThreshold: i == values.count - 1 ? dragLimit : thumbPosition(i + 1) - thumbPaddingWidth,
                                val: getFakeValBinding(i),
                                realVal: getValueBinding(binding: values[i]),
                                textOnTop: i % 2 == 0)
                }
            }
        }
    }
    
    func getValueBinding(binding: Binding<Int>) -> Binding<CGFloat> {
        return Binding(get: { return CGFloat(binding.wrappedValue) },
                       set: { (newValue) in binding.wrappedValue = self.widthToValue(newValue) })
    }
    
    func getFakePosBinding(_ i: Int) -> Binding<CGFloat> {
        return Binding(get: { return self.valueToWidth(fakeValues[i]) - self.thumbAdjustment },
                       set: {_ in })
    }
    
    func getFakeValBinding(_ i: Int) -> Binding<CGFloat> {
        return Binding(get: { return CGFloat(fakeValues[i]) },
                       set: { newVal in fakeValues[i] = self.widthToValue(newVal) })
    }
    
    func thumbPosition(_ i: Int) -> CGFloat {
        return getFakePosBinding(i).wrappedValue
    }
    
    private func getSection(section: Int) -> some View {
        let startVal = section == 0 ? rangeStart : values[section - 1].wrappedValue
        let endVal = section == values.count ? rangeEnd : values[section].wrappedValue
        
        return HStack(spacing: 0) {
            if (startVal == rangeStart) {
                barCap(endCap: false)
            }
            Rectangle()
                .fill(valueColors[section])
                .frame(width: sectionWidth(section),
                       height: sliderHeight)
            if (endVal == rangeEnd) {
                barCap(endCap: true)
            }
        }
    }
    
    func barCap(endCap: Bool) -> some View {
        return HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: sliderHeight)
                .fill(endCap ? valueColors[sections - 1] : valueColors[0])
                .frame(width: sliderHeight,
                       height: sliderHeight)
                .offset(x: sliderHeight / 2)
            Rectangle()
                .fill(endCap ? valueColors[sections - 1] : valueColors[0])
                .frame(width: sliderHeight / 2,
                       height: sliderHeight)
        }.frame(height: sliderHeight)
         .rotationEffect(.degrees(endCap ? 180 : 0))
    }
    
    private func sectionWidth(_ i: Int) -> CGFloat {
        switch i {
            case 0: return valueToWidth(fakeValues[0])
            case sections - 1: return valueToWidth(rangeStart + rangeEnd - fakeValues[i - 1])
            default: return valueToWidth((fakeValues[i] - fakeValues[i - 1]) + rangeStart)
        }
    }
    
    private func valueToWidth(_ val: Int) -> CGFloat {
        return CGFloat((val - rangeStart)) / CGFloat(rangeEnd - rangeStart) * sliderWidth
    }
    
    private func widthToValue(_ width: CGFloat) -> Int {
        let wholeNum = Int(round((width + thumbAdjustment) * CGFloat(rangeEnd - rangeStart) / sliderWidth + CGFloat(rangeStart)))
        
        return wholeNum - wholeNum % step
    }
}

struct MultiSlider_Previews: PreviewProvider {
    static var previews: some View {
        //MultiSlider()
        EmptyView()
    }
}

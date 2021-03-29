//
//  TimeBar2.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct TimeBar: View {
    @EnvironmentObject var colors: Colors
    
    var low: CGFloat
    let lowLessThanOne: Bool
    var mid: CGFloat
    let midLessThanOne: Bool
    var high: CGFloat
    let highLessThanOne: Bool
    let minBarWidth = Dimensions.BASE_UNIT * 16
    let midBarWidth = Dimensions.BASE_UNIT * 168
    let barHeight = Dimensions.BASE_UNIT * 26
    
    init(_ low: CGFloat, _ mid: CGFloat, _ high: CGFloat) {
        var lessCount = 0
        
        self.lowLessThanOne = low > 0.0 && low < 1.0
        self.low = self.lowLessThanOne ? 1 : low
        if lowLessThanOne { lessCount += 1 }
        
        self.midLessThanOne = mid > 0.0 && mid < 1.0
        self.mid = self.midLessThanOne ? 1 : mid
        if midLessThanOne { lessCount += 1 }
        
        self.highLessThanOne = high > 0.0 && high < 1.0
        self.high = self.highLessThanOne ? 1 : high
        if highLessThanOne { lessCount += 1 }
        
        if lessCount == 0 {
            self.low = round(self.low)
            self.mid = round(self.mid)
            self.high = round(self.high)
        } else if lessCount == 1 {
            if self.lowLessThanOne {
                self.mid = floor(self.mid)
                self.high = floor(self.high)
            }
            if self.midLessThanOne {
                self.low = floor(self.low)
                self.high = floor(self.high)
            }
            if self.highLessThanOne {
                self.low = floor(self.low)
                self.mid = floor(self.mid)
            }
        } else if lessCount == 2 {
            if self.midLessThanOne && self.highLessThanOne {
                self.low -= (1 - mid) + (1 - high)
            }
            if self.lowLessThanOne && self.highLessThanOne {
                self.mid -= (1 - low) + (1 - high)
            }
            if self.lowLessThanOne && self.midLessThanOne {
                self.high -= (1 - low) + (1 - mid)
            }
        }
        
        if self.low + self.mid + self.high == 99 { self.mid += 1 }
        if self.low + self.mid + self.high == 101 {
            if self.low >= 2 { self.low -= 1 }
            else if self.mid >= 2 { self.mid -= 1 }
            else if self.high >= 2 { self.high -= 1 }
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if (low > 0) {
                buildRange(timeCovered: 0, buildBgTime(range: .low, time: Int(self.low)))
            }
            if (mid > 0) {
                buildRange(timeCovered: Int(low), buildBgTime(range: .mid, time: Int(self.mid)))
            }
            if (high > 0) {
                buildRange(timeCovered: Int(low + mid), buildBgTime(range: .high, time: Int(self.high)))
            }
        }
    }
    
    func buildBgTime(range: Range, time: Int) -> BgTime {
        return BgTime(range, time: time, colors: _colors)
    }
    
    func buildRange(timeCovered: Int, _ range: BgTime) -> some View {
        return VStack() {
            if (timeCovered == 0) {
                buildStartCap(range)
            } else if (timeCovered <= 92) {
                buildBar(range, range.time, timeCovered: timeCovered)
            } else {
                buildEndCap(range)
            }
            HStack(spacing: 0) {
                Text("\(range.time)")
                    .font(.title3)
                    .fixedSize()
                    .frame(width: 16)
            }
        }
    }
    
    func buildStartCap(_ range: BgTime) -> some View {
        return HStack(spacing: 0) {
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(range.color())
                .rotationEffect(.degrees(90))
                .frame(width: minBarWidth * 2, height: barHeight)
                .frame(width: minBarWidth)
                .offset(x: minBarWidth / 2)
            if (range.time > 8) {
                buildBar(range, range.time - 8, timeCovered: 8)
            }
        }
    }
    
    func buildBar(_ range: BgTime, _ timeLeft: Int, timeCovered: Int) -> some View {
        var barWidth: CGFloat
        
        if (timeLeft >= 84) {
            barWidth = midBarWidth
        } else if ((timeCovered + timeLeft) == 100) {
            barWidth = Dimensions.BASE_UNIT * CGFloat(Double(timeLeft) * 2) - 16
        } else {
            barWidth = Dimensions.BASE_UNIT * CGFloat(Double(timeLeft) * 2)
        }
        
        if (range.range == .mid &&
            low > 0 &&
            high > 0 &&
            barWidth < 16) {
            barWidth = minBarWidth
        }
        
        return HStack(spacing: 0) {
            if (range.time == timeLeft) {
                Spacer().frame(width: 3)
            }
            Rectangle()
                .fill(range.color())
                .frame(width: barWidth, height: barHeight)
            if ((timeCovered + timeLeft) == 100) {
                buildEndCap(range)
            }
        }
        
    }
    
    func buildEndCap(_ range: BgTime) -> some View {
        return Circle()
                .trim(from: 0, to: 0.5)
                .fill(range.color())
                .rotationEffect(.degrees(-90))
                .frame(width: minBarWidth * 2, height: barHeight)
            .frame(width: minBarWidth)
            .offset(x: -minBarWidth / 2)
    }
}

struct TimeBar_Previews: PreviewProvider {
    static var previews: some View {
        TimeBar(8, 40, 52).environmentObject(Colors())
    }
}

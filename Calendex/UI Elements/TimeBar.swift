//
//  TimeBar2.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct TimeBar: View {
    @EnvironmentObject var colors: Colors
    
    let low: Int
    let mid: Int
    let high: Int
    let minBarWidth = Dimensions.BASE_UNIT * 16
    let midBarWidth = Dimensions.BASE_UNIT * 168
    let barHeight = Dimensions.BASE_UNIT * 26
    
    init(_ low: Int, _ mid: Int, _ high: Int) {
        //self.low = BgTime(.low, time: low, colors: _colors)
        //self.mid = BgTime(.mid, time: mid, colors: _colors)
        //self.high = BgTime(.high, time: high, colors: _colors)
        
        self.low = low
        self.mid = mid
        self.high = high
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if (low > 0) {
                buildRange(timeCovered: 0, buildBgTime(range: .low, time: self.low))
            }
            if (mid > 0) {
                buildRange(timeCovered: low, buildBgTime(range: .mid, time: self.mid))
            }
            if (high > 0) {
                buildRange(timeCovered: low + mid, buildBgTime(range: .high, time: self.high))
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
                    .font(.system(size: 15))
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

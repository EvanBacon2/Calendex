//
//  TimeBar2.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct TimeBar2: View {
    let low: BgTime
    let mid: BgTime
    let high: BgTime
    let minBarWidth = Dimensions.BASE_UNIT * 16
    let midBarWidth = Dimensions.BASE_UNIT * 168
    let barHeight = Dimensions.BASE_UNIT * 32
    
    init(_ low: Int, _ mid: Int, _ high: Int) {
        self.low = BgTime(.low, time: low)
        self.mid = BgTime(.mid, time: mid)
        self.high = BgTime(.high, time: high)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if (low.time > 0) {
                buildRange(timeCovered: 0, low)
            }
            if (mid.time > 0) {
                buildRange(timeCovered: low.time, mid)
            }
            if (high.time > 0) {
                buildRange(timeCovered: low.time + mid.time, high)
            }
        }
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
                .fill(range.color)
                .rotationEffect(.degrees(90))
                .frame(width: minBarWidth * 2, height: minBarWidth * 2)
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
            low.time > 0 &&
            high.time > 0 &&
            barWidth < 16) {
            barWidth = minBarWidth
        }
        
        return HStack(spacing: 0) {
            if (range.time == timeLeft) {
                Spacer().frame(width: 3)
            }
            Rectangle()
                .fill(range.color)
                .frame(width: barWidth, height: barHeight)
            if ((timeCovered + timeLeft) == 100) {
                buildEndCap(range)
            }
        }
        
    }
    
    func buildEndCap(_ range: BgTime) -> some View {
        return Circle()
                .trim(from: 0, to: 0.5)
                .fill(range.color)
                .rotationEffect(.degrees(-90))
                .frame(width: minBarWidth * 2, height: minBarWidth * 2)
            .frame(width: minBarWidth)
            .offset(x: -minBarWidth / 2)
    }
}

struct TimeBar2_Previews: PreviewProvider {
    static var previews: some View {
        TimeBar2(8, 40, 52)
    }
}

//
//  TimeBar2.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct TimeBar: View {
    @EnvironmentObject var colors: Colors
    
    var low: BgTime
    var mid: BgTime
    var high: BgTime
    
    let minPercent = 3
    let spacePercent = 1
    var totalPercent = 100
    let percentWidth = Dimensions.BASE_UNIT * 2
    let minBarWidth: CGFloat
    let maxBarWidth: CGFloat
    let barHeight = Dimensions.BASE_UNIT * 26
    
    init(_ low: Int, _ mid: Int, _ high: Int) {
        self.low = BgTime(.low, time: low)
        self.mid = BgTime(.mid, time: mid)
        self.high = BgTime(.high, time: high)
        var smallPadding = 0
        var spacePadding = -1
        
        for range in [low, mid, high] {
            if range > 0 {
                spacePadding += spacePercent
            }
        }
        
        self.totalPercent -= spacePadding
        
        self.minBarWidth = CGFloat(minPercent) * percentWidth
        self.maxBarWidth = CGFloat(totalPercent) * percentWidth - 2 * minBarWidth
        
        let paddedTimes = [self.low, self.mid, self.high].map {
            time -> BgTime in
                if time.time > 0 && time.time < minPercent {
                    smallPadding += minPercent - time.time
                    return BgTime(time.range, time: minPercent)
                }
                return time
        }
        
        self.low = paddedTimes[0]
        self.mid = paddedTimes[1]
        self.high = paddedTimes[2]
        
        let  maxRange = [self.low, self.mid, self.high].max { $0.time < $1.time }
        switch maxRange!.range {
        case .low:
            self.low.time -= smallPadding + spacePadding
        case .mid:
            self.mid.time -= smallPadding + spacePadding
        case .high:
            self.high.time -= smallPadding + spacePadding
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if low.time > 0 {
                buildRange(timeCovered: 0, self.low)
            }
            if mid.time > 0 {
                buildRange(timeCovered: low.time, self.mid)
            }
            if high.time > 0 {
                buildRange(timeCovered: low.time + mid.time, self.high)
            }
        }
    }
    
    func buildRange(timeCovered: Int, _ range: BgTime) -> some View {
        return VStack() {
            if (timeCovered == 0) {
                buildStartCap(range)
            } else if (timeCovered < totalPercent - minPercent) {
                buildBar(range, timeLeft: range.time, timeCovered: timeCovered)
            } else {
                buildEndCap(range)
            }
        }
    }
    
    func buildStartCap(_ range: BgTime) -> some View {
        return HStack(spacing: 0) {
            cap(range.range)
            if (range.time > minPercent) {
                buildBar(range, timeLeft: range.time - minPercent, timeCovered: minPercent)
            }
        }
    }
    
    func buildBar(_ range: BgTime, timeLeft: Int, timeCovered: Int) -> some View {
        var barWidth: CGFloat
        
        if (timeLeft >= totalPercent - minPercent * 2) {
            barWidth = maxBarWidth
        } else if ((timeCovered + timeLeft) == totalPercent) {
            barWidth = percentWidth * CGFloat(timeLeft - minPercent)
        } else {
            barWidth = percentWidth * CGFloat(timeLeft)
        }
        
        if (range.range == .mid &&
            low.time > 0 &&
            high.time > 0 &&
            barWidth < minBarWidth) {
            barWidth = minBarWidth
        }
        
        return HStack(spacing: 0) {
            if (range.time == timeLeft) {
                Spacer().frame(width: percentWidth * CGFloat(spacePercent))
            }
            Rectangle()
                .fill(colors.getActiveColor(range: range.range))
                .frame(width: barWidth, height: barHeight)
            if ((timeCovered + timeLeft) == totalPercent) {
                buildEndCap(range)
            }
        }
        
    }
    
    func buildEndCap(_ range: BgTime) -> some View {
        return HStack(spacing: 0) {
            if range.time <= minPercent {
                Spacer().frame(width: percentWidth * CGFloat(spacePercent))
            }
            cap(range.range, endCap: true)
        }
    }
    
    func cap(_ range: Range, endCap: Bool = false) -> some View {
        return ZStack(alignment: endCap ? .leading : .trailing) {
            RoundedRectangle(cornerRadius: 7)
                .fill(colors.getActiveColor(range: range))
                .frame(width: minBarWidth, height: barHeight)
            Rectangle()
                .fill(colors.getActiveColor(range: range))
                .frame(width: 3.5, height: barHeight)
        }
    }
}

struct TimeBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            Group {// 3 Colors
                TimeBar(30, 40, 30).environmentObject(Colors())
                TimeBar(1, 69, 30).environmentObject(Colors())
                TimeBar(49, 2, 49).environmentObject(Colors())
                TimeBar(30, 69, 1).environmentObject(Colors())
                TimeBar(1, 98, 1).environmentObject(Colors())
            }
            Spacer().frame(height: UIScreen.screenHeight * 0.02)
            Group {// 2 Colors
                TimeBar(12, 88, 0).environmentObject(Colors())
                TimeBar(0, 88, 12).environmentObject(Colors())
                TimeBar(0, 99, 1).environmentObject(Colors())
                TimeBar(0, 1, 99).environmentObject(Colors())
                TimeBar(99, 1, 0).environmentObject(Colors())
                TimeBar(1, 99, 0).environmentObject(Colors())
            }
            Spacer().frame(height: UIScreen.screenHeight * 0.02)
            Group {// 1 Color
                TimeBar(100, 0, 0).environmentObject(Colors())
                TimeBar(0, 100, 0).environmentObject(Colors())
                TimeBar(0, 0, 100).environmentObject(Colors())
            }
        }
    }
}

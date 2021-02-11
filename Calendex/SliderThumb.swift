//
//  SliderThumb.swift
//  Calendex
//
//  Created by Evan Bacon on 2/10/21.
//

import SwiftUI

struct SliderThumb: View {
    @State private var startPos: CGFloat = 0.0
    @State private var prevDelta: CGFloat = 0.0
    @State private var sliderPos: CGFloat = 0.0
    
    var pos: Int
    @Binding var limits: [CGFloat]
    
    init(pos: Int, limits: Binding<[CGFloat]>) {
        self.pos = pos
        self._limits = limits
        self._startPos = State(initialValue: self.limits[pos])
        self._sliderPos = State(initialValue: self.limits[pos])
    }
    
    var sliderDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged {gesture in
                let prevSliderPos = startPos + prevDelta
                let newSliderPos = startPos + gesture.translation.width
                
                if (prevSliderPos > threshold(pos-1, true) &&
                    prevSliderPos < threshold(pos+1, false)) {
                    sliderPos = calcNewSliderPos(newSliderPos)
                    prevDelta = gesture.translation.width
                    prevDelta -= shaveDelta(sliderPos)
                } else if (prevSliderPos == threshold(pos-1, true)) {
                    if (newSliderPos >= threshold(pos-1, true)) {
                        sliderPos = newSliderPos
                        prevDelta = gesture.translation.width
                    }
                } else if (prevSliderPos == threshold(pos+1, false)) {
                    if (newSliderPos <= threshold(pos+1, false)) {
                        sliderPos = newSliderPos
                        prevDelta = gesture.translation.width
                    }
                }
                
                limits[pos] = sliderPos
            }.onEnded {_ in
                startPos = sliderPos
                prevDelta = 0.0
                limits[pos] = sliderPos
            }
    }
    
    func calcNewSliderPos(_ newPos: CGFloat) -> CGFloat {
        if (newPos < threshold(pos-1, true)) {
            return threshold(pos-1, true)
        } else if (newPos > threshold(pos+1, false)) {
            return threshold(pos+1, false)
        } else {
            return newPos
        }
    }
    
    func shaveDelta(_ sliderPos: CGFloat) -> CGFloat {
        if (sliderPos < threshold(pos-1, true)) {
            return sliderPos - threshold(pos-1, true)
        } else if (sliderPos > threshold(pos+1, false)) {
            return threshold(pos+1, false) - sliderPos
        } else {
            return 0.0
        }
    }
    
    func threshold(_ pos: Int, _ approachRight: Bool) -> CGFloat {
        if (pos == 0 || pos == limits.count - 1) {
            return limits[pos]
        } else {
            if (approachRight) {
                return limits[pos] + 10
            } else {
                return limits[pos] - 10
            }
        }
    }
    
    var body: some View {
        Rectangle()
            .fill(AppColors.LIGHT_BLUE_GRAY)
            .frame(width: Dimensions.BASE_UNIT * 3, height: Dimensions.BASE_UNIT * 11)
            .offset(x: self.sliderPos)
            .gesture(sliderDrag)
    }
}

struct SliderThumb_Previews: PreviewProvider {
    @State static var limits: [CGFloat] = [-20.0, 0.0, 20.0]
    
    static var previews: some View {
        SliderThumb(pos: 1, limits: $limits)
    }
}

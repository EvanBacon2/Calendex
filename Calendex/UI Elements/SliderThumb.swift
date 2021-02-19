//
//  SliderThumb.swift
//  Calendex
//
//  Created by Evan Bacon on 2/10/21.
//

import SwiftUI

struct SliderThumb: View {
    @EnvironmentObject var colors: Colors
    
    @Binding var val: CGFloat
    @Binding private var sliderPos: CGFloat
    
    @State private var startPos: CGFloat = 0.0
    @State private var prevDelta: CGFloat = 0.0
    
    var lowThreshold: CGFloat
    var highThreshold: CGFloat
    
    var textOnTop: Bool
    
    init(startPos: Binding<CGFloat>, lowThreshold: CGFloat, highThreshold: CGFloat, val: Binding<CGFloat>, textOnTop: Bool) {
        self._val = val
        self._startPos = State(initialValue: startPos.wrappedValue)
        self._sliderPos = startPos
        
        self.lowThreshold = lowThreshold
        self.highThreshold = highThreshold
        
        self.textOnTop = textOnTop
    }
    
    var sliderDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged {gesture in
                let newSliderPos = startPos + gesture.translation.width
                
                if (newSliderPos >= lowThreshold &&
                        newSliderPos <= highThreshold) {
                    self.val = checkBounds(newSliderPos)
                    prevDelta = gesture.translation.width
                    prevDelta -= shaveDelta(sliderPos)
                }
            }.onEnded {_ in
                startPos = sliderPos
                prevDelta = 0.0
            }
    }
    
    func checkBounds(_ newPos: CGFloat) -> CGFloat {
        if (newPos < lowThreshold) {
            return lowThreshold
        } else if (newPos > highThreshold) {
            return highThreshold
        } else {
            return newPos
        }
    }
    
    func shaveDelta(_ sliderPos: CGFloat) -> CGFloat {
        if (sliderPos < lowThreshold) {
            return sliderPos - lowThreshold
        } else if (sliderPos > highThreshold) {
            return highThreshold - sliderPos
        } else {
            return 0.0
        }
    }
    
    var body: some View {
        VStack(spacing: 1) {
            if (textOnTop) {
                Text("\(Int(self.val))")
                    .font(.system(size: 12))
                    .foregroundColor(colors.DARK_GRAY)
                    .offset(x: self.sliderPos, y: -7)
                    .fixedSize()
                    .frame(height: 1.0)
            }
            Rectangle()
                .fill(colors.LIGHT_BLUE_GRAY)
                .frame(width: Dimensions.BASE_UNIT * 3,
                       height: Dimensions.BASE_UNIT * 11)
                .offset(x: self.sliderPos)
                .gesture(sliderDrag)
            if (!textOnTop) {
                Text("\(Int(self.val))")
                    .font(.system(size: 12))
                    .foregroundColor(colors.DARK_GRAY)
                    .offset(x: self.sliderPos, y: 7)
                    .fixedSize()
                    .frame(height: 1.0)
            }
        }
    }
}

struct SliderThumb_Previews: PreviewProvider {
    static var previews: some View {
        SliderThumb_Preview_Container()
    }
}

struct SliderThumb_Preview_Container: View {
    var dragLimit: CGFloat = UIScreen.screenWidth * (0.425) - UIScreen.screenHeight * 0.0115
    @State var val: CGFloat = 0.0
    
    var body: some View {
        VStack() {
            /*Text(String("\(val)"))
            SliderThumb(startPos: 0, lowThreshold: -dragLimit, highThreshold: dragLimit, updateGoal: Binding(get: { return val },
                set: { (newVal) in val = newVal }))*/
        }
    }
}

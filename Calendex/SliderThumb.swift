//
//  SliderThumb.swift
//  Calendex
//
//  Created by Evan Bacon on 2/10/21.
//

import SwiftUI

struct SliderThumb: View {
    @Binding var val: Int
    
    @State private var startPos: CGFloat = 0.0
    @State private var prevDelta: CGFloat = 0.0
    @State private var sliderPos: CGFloat = 0.0
    @State private var lowThreshold: CGFloat = 0.0
    @State private var highThreshold: CGFloat = 0.0
    
    init(startPos: CGFloat, lowThreshold: CGFloat, highThreshold: CGFloat, updateGoal: Binding<Int>) {
        self._startPos = State(initialValue: startPos)
        self._sliderPos = State(initialValue: startPos)
        self._lowThreshold = State(initialValue: lowThreshold)
        self._highThreshold = State(initialValue: highThreshold)
        self._val = updateGoal
    }
    
    var sliderDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged {gesture in
                //let prevSliderPos = startPos + prevDelta
                let newSliderPos = startPos + gesture.translation.width
                
                if (newSliderPos >= lowThreshold &&
                        newSliderPos <= highThreshold) {
                    sliderPos = checkBounds(newSliderPos)
                    prevDelta = gesture.translation.width
                    prevDelta -= shaveDelta(sliderPos)
                }
                
                /*if (prevSliderPos > lowThreshold &&
                    prevSliderPos < highThreshold) {
                    sliderPos = checkBounds(newSliderPos)
                    prevDelta = gesture.translation.width
                    prevDelta -= shaveDelta(sliderPos)
                 
                } else if (prevSliderPos == lowThreshold &&
                           newSliderPos >= lowThreshold  ||
                           prevSliderPos == highThreshold &&
                           newSliderPos <= highThreshold) {
                    sliderPos = checkBounds(newSliderPos)
                    prevDelta = gesture.translation.width
                }*/
                self.val = Int(round(sliderPos))
            }.onEnded {_ in
                startPos = sliderPos
                prevDelta = 0.0
                self.val = Int(round(sliderPos))
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
        Rectangle()
            .fill(AppColors.LIGHT_BLUE_GRAY)
            .frame(width: Dimensions.BASE_UNIT * 3, height: Dimensions.BASE_UNIT * 11)
            .offset(x: self.sliderPos)
            .gesture(sliderDrag)
    }
}

struct SliderThumb_Previews: PreviewProvider {
    static var previews: some View {
        SliderThumb_Preview_Container()
    }
}

struct SliderThumb_Preview_Container: View {
    var dragLimit: CGFloat = UIScreen.screenWidth * (0.425) - UIScreen.screenHeight * 0.0115
    @State var val = 0
    
    var body: some View {
        VStack() {
            Text(String("\(val)"))
            SliderThumb(startPos: 0, lowThreshold: -dragLimit, highThreshold: dragLimit, updateGoal: Binding(get: { return val },
                set: { (newVal) in val = newVal }))
        }
    }
}

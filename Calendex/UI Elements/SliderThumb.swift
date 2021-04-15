//
//  SliderThumb.swift
//  Calendex
//
//  Created by Evan Bacon on 2/10/21.
//

import SwiftUI

struct SliderThumb: View {
    @Binding var val: CGFloat
    @Binding private var sliderPos: CGFloat
    
    @State private var selected: Bool = false
    @State private var fontSize: CGFloat = 14.0
    @State private var startPos: CGFloat = 0.0
    @State private var prevDelta: CGFloat = 0.0
    
    @State private var topOff: CGFloat = Dimensions.BASE_UNIT * -6
    @State private var bottomOff: CGFloat = Dimensions.BASE_UNIT * 6
    
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
                withAnimation(Animation.default) {
                    fontSize = 20
                    topOff = Dimensions.BASE_UNIT * -17
                    bottomOff = Dimensions.BASE_UNIT * -29
                }
                
                selected = true
                
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
                selected = false
                withAnimation(Animation.default) {
                    fontSize = 14
                    topOff = Dimensions.BASE_UNIT * -6
                    bottomOff = Dimensions.BASE_UNIT * 6
                }
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
                thumbCaption(top: true)
            }
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: Dimensions.BASE_UNIT * 3,
                       height: Dimensions.BASE_UNIT * 11)
                .offset(x: self.sliderPos)
                .gesture(sliderDrag)
            if (!textOnTop) {
                thumbCaption(top: false)
            }
        }
    }
    
    func thumbCaption(top: Bool) -> some View {
        let offset: CGFloat = top ? topOff : bottomOff
        
        return Text("\(Int(self.val))")
                .foregroundColor(AppColors.DARK_GRAY)
                .animatableFont(name: "San Francisco", size: fontSize)
                .offset(y: offset)
                .offset(x: self.sliderPos)
                .fixedSize()
                .frame(height: 1.0)
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

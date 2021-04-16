//
//  SliderThumb.swift
//  Calendex
//
//  Created by Evan Bacon on 2/10/21.
//

import SwiftUI

struct SliderThumb: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    @Binding var val: CGFloat
    @Binding var realVal: CGFloat
    @Binding private var sliderPos: CGFloat
    
    @State private var selected: Bool = false
    @State private var startPos: CGFloat = 0.0
    
    @State private var fontSize: CGFloat = 14.0
    @State private var textOffset: CGFloat
    
    let lowThreshold: CGFloat
    let highThreshold: CGFloat
    
    let textOnTop: Bool
    
    init(startPos: Binding<CGFloat>, lowThreshold: CGFloat, highThreshold: CGFloat, val: Binding<CGFloat>, realVal: Binding<CGFloat>, textOnTop: Bool) {
        self._val = val
        self._realVal = realVal
        self._startPos = State(initialValue: startPos.wrappedValue)
        self._sliderPos = startPos
        
        self.lowThreshold = lowThreshold
        self.highThreshold = highThreshold
        
        self.textOnTop = textOnTop
        self._textOffset = State(wrappedValue: textOnTop ? Dimensions.BASE_UNIT * -2 : Dimensions.BASE_UNIT * 2)
    }
    
    var sliderDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged {gesture in
                withAnimation(Animation.default) {
                    fontSize = 20
                    textOffset = textOnTop ? Dimensions.BASE_UNIT * -17 : Dimensions.BASE_UNIT * -29
                }
                selected = true
                
                val = checkBounds(startPos + gesture.translation.width)
            }.onEnded {_ in
                startPos = sliderPos
                realVal = sliderPos
                selected = false
                withAnimation(Animation.default) {
                    fontSize = 14
                    textOffset = textOnTop ? Dimensions.BASE_UNIT * -2 : Dimensions.BASE_UNIT * 2
                }
            }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            if (textOnTop) {
                thumbCaption(top: true)
            }
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: Dimensions.BASE_UNIT * 3,
                       height: Dimensions.BASE_UNIT * 11)
                .offset(x: self.sliderPos, y: textOnTop ? -1.0 : 1.0)
                .gesture(sliderDrag)
                .fixedSize()
                .frame(width: Dimensions.BASE_UNIT * 9,
                       height: Dimensions.BASE_UNIT * 22)
            if (!textOnTop) {
                thumbCaption(top: false)
            }
        }.frame(width: Dimensions.BASE_UNIT * 9, height: Dimensions.BASE_UNIT * 33)
        .gesture(sliderDrag)
    }
    
    func thumbCaption(top: Bool) -> some View {
        return Text("\(Int(self.val))")
                .foregroundColor(colors.fillerTextColor(colorScheme))
                .animatableFont(name: "San Francisco", size: fontSize)
                .offset(y: textOffset)
                .offset(x: self.sliderPos)
                .fixedSize()
                .frame(height: 1.0)
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

//
//  MultiSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/6/21.
//

import SwiftUI

struct MultiSlider: View {
    @State private var startPos: CGFloat = 0.0
    @State private var prevDelta: CGFloat = 0.0
    @State private var sliderPos: CGFloat = 0.0
    private var dragLimit: CGFloat = UIScreen.screenWidth * 0.42
    
    var sliderDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged {gesture in
                let prevSliderPos = startPos + prevDelta
                let newSliderPos = startPos + gesture.translation.width
                let isLeft: CGFloat = pow(-1, sliderPos < 0 ? 1 : 0)
                
                if (abs(prevSliderPos) < dragLimit) {
                    sliderPos = abs(newSliderPos) > dragLimit ? dragLimit * isLeft : newSliderPos
                    prevDelta =  gesture.translation.width
                    prevDelta -= abs(sliderPos) > dragLimit ?
                        ((abs(sliderPos) - dragLimit) *
                            isLeft) : 0.0
                } else if (abs(prevSliderPos) == dragLimit) {
                    if (abs(newSliderPos) <= dragLimit) {
                        sliderPos = newSliderPos
                        prevDelta = gesture.translation.width
                    }
                }
            }.onEnded {_ in
                startPos = sliderPos
                prevDelta = 0.0
                
            }
    }
    
    var body: some View {
        ZStack() {
            HStack(spacing: 0) {
                Spacer().frame(width: 10)
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColors.LOW_2)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                Rectangle()
                    .fill(AppColors.LOW_2)
                    .frame(width: UIScreen.screenWidth * 0.1,
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                Rectangle()
                    .fill(AppColors.MID_2)
                    .frame(width: UIScreen.screenWidth * 0.6,
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                Rectangle()
                    .fill(AppColors.HIGH_2)
                    .frame(width: UIScreen.screenWidth * 0.15,
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColors.HIGH_2)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -10)
            }
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: 3, height: 12)
                .offset(x: self.sliderPos)
                .gesture(sliderDrag)
        }
    }
}

struct MultiSlider_Previews: PreviewProvider {
    static var previews: some View {
        MultiSlider()
    }
}

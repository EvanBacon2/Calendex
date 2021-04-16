//
//  SliderRuler.swift
//  Calendex
//
//  Created by Evan Bacon on 2/6/21.
//

import SwiftUI

struct SliderRuler: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    var markings: [Int]
    var rulerRange: CGFloat
    var rulerWidth: CGFloat
    
    init(markings: [Int]) {
        self.markings = markings
        self.rulerRange = CGFloat(markings[markings.count - 1] - markings[0])
        self.rulerWidth = (UIScreen.screenWidth * 0.85 - UIScreen.screenHeight * 0.023)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0){
                ForEach(0..<markings.count - 1) { i in
                    rulerText(text: "\(markings[i])")
                    rulerSpace(unitWidth: markings[i+1] - markings[i])
                }
                rulerText(text: "\(markings[markings.count - 1])")
            }.frame(width: rulerWidth)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(rulerColor())
                .frame(width: rulerWidth, height: Dimensions.BASE_UNIT * 2)
            
            HStack(spacing: 0) {
                ForEach(0..<markings.count - 1) { i in
                    rulerMarking()
                    rulerSpace(unitWidth: markings[i+1] - markings[i])
                }
                rulerMarking()
            }.frame(width: rulerWidth)
            .offset(y: -1)
        }
    }
    
    func rulerText(text: String) -> some View {
        return Text(text)
            .font(.callout)
            .foregroundColor(textColor())
            .fixedSize()
            .frame(width: 1.0)
    }
    
    func rulerMarking() -> some View {
        return RoundedRectangle(cornerRadius: 5)
            .fill(rulerColor())
            .frame(width: Dimensions.BASE_UNIT *  2)
            .fixedSize()
            .frame(width: 1.0,
                   height: UIScreen.screenHeight * 0.010)
    }
    
    func textColor() -> Color{
        switch colorScheme {
            case .light: return AppColors.DARK_GRAY
            case .dark: return AppColors.LIGHT_BLUE_GRAY
            default: return AppColors.DARK_GRAY
        }
    }
    
    func rulerColor() -> Color {
        switch colorScheme {
            case .light: return AppColors.LIGHT_BLUE_GRAY
            case .dark: return AppColors.DARK_GRAY
            default: return AppColors.DARK_GRAY
        }
    }
    
    func rulerSpace(unitWidth: Int) -> some View {
        return Spacer().frame(width: (CGFloat(unitWidth) - 0.5) / rulerRange * rulerWidth)
    }
}

struct SliderRuler_Previews: PreviewProvider {
    static var previews: some View {
        SliderRuler(markings: [0, 25, 50, 75, 100]).environmentObject(Colors())
    }
}

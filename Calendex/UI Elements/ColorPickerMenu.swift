//
//  ColorPickerMenu.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct ColorPickerMenu: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    let togglePicker: () -> Void
    
    var circleDiameter = UIScreen.screenWidth * 0.1
    var circleSpacing = UIScreen.screenWidth * 0.022
    
    var range: Range
    var alignment: CGFloat
    
    init(range: Range, alignment: Alignment, togglePicker: @escaping () -> Void) {
        self.togglePicker = togglePicker
        
        self.range = range
        switch alignment {
        case .leading:
            self.alignment = circleDiameter + circleSpacing
        case .center:
            self.alignment = 0.0
        case .trailing:
            self.alignment = -(circleDiameter + circleSpacing)
        default:
            self.alignment = 0.0
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            pickerBox()
            pickerOptions()
        }
    }
    
    func pickerBox() -> some View {
        return VStack(spacing: 0) {
            /*PickerBoxTriangle()
                .fill(colors.boxColor(colorScheme))
                .frame(width: circleDiameter / 3,
                       height: circleDiameter / 3)*/
            RoundedRectangle(cornerRadius: 5)
                .fill(colors.boxColor(colorScheme))
                .frame(width: ((circleDiameter + circleSpacing) * CGFloat(AppColors.RANGE_COLOR_OPTIONS)) + circleSpacing,
                       height: circleDiameter + circleSpacing * 2)
                .fixedSize()
                .frame(width: circleDiameter)
                .offset(x: alignment)
        }
    }
    
    func pickerOptions() -> some View {
        return HStack(spacing: circleSpacing) {
            ForEach(0..<3) { i in
                Button(action: {() -> Void in
                    togglePicker()
                    colors.setActiveColor(range: range, newColor: colors.getColor(range: range, index: i))
                }) {
                    Circle()
                        .fill(colors.getColor(range: range, index: i))
                        .frame(width: circleDiameter,
                               height: circleDiameter)
                }
            }
        }.frame(height: circleDiameter + circleSpacing * 2)
        .fixedSize()
        .frame(width: circleDiameter)
        .offset(x: alignment)
    }
}

struct ColorPickerMenu_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerMenu_Preview_View().environmentObject(Colors())
    }
}

struct ColorPickerMenu_Preview_View: View {
    var body: some View {
        ColorPickerMenu(range: .low, alignment: .leading, togglePicker: {() -> Void in })
    }
}

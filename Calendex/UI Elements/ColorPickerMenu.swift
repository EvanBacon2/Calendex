//
//  ColorPickerMenu.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct ColorPickerMenu: View {
    @Binding var showPicker: Bool
    
    var circleDiameter = Dimensions.BASE_UNIT * 27
    var circleSpacing = Dimensions.BASE_UNIT * 6
    
    var range: Range
    var alignment: CGFloat
    
    init(range: Range, alignment: Alignment, showPicker: Binding<Bool>) {
        self._showPicker = showPicker
        
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
            PickerBoxTriangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: circleDiameter / 3,
                       height: circleDiameter / 3)
            RoundedRectangle(cornerRadius: 5)
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: ((circleDiameter + circleSpacing) * CGFloat(AppColors.RANGE_COLOR_OPTIONS)) + circleSpacing,
                       height: 45)
                .fixedSize()
                .frame(width: circleDiameter)
                .offset(x: alignment)
        }
    }
    
    func pickerOptions() -> some View {
        return HStack(spacing: circleSpacing) {
            ForEach(0..<3) { i in
                Button(action: {() -> Void in showPicker.toggle()
                    AppColors.setActiveColor(range: range, newColor: AppColors.getColor(range: range, index: i))
                }) {
                    Circle()
                        .fill(AppColors.getColor(range: range, index: i))
                        .frame(width: circleDiameter,
                               height: circleDiameter)
                }
            }
        }.frame(height: 45)
        .fixedSize()
        .frame(width: 30)
        .offset(x: alignment)
    }
}

struct ColorPickerMenu_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerMenu_Preview_Provider()
    }
}

struct ColorPickerMenu_Preview_Provider: View {
    @State var showPicker = true
    
    var body: some View {
        ColorPickerMenu(range: .low, alignment: .leading, showPicker: $showPicker)
    }
}

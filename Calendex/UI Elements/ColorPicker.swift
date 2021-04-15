//
//  ColorPicker.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct ColorPicker: View {
    @EnvironmentObject var colors: Colors
    
    @Binding var toggleAvailable: Bool
    
    @State private var toggled: Bool = false
    @State private var pickerOffset: CGFloat = 40.0
    @State private var pickerScale: CGFloat = 0.0
    
    var circleDiameter = UIScreen.screenWidth * 0.1
    
    var range: Range
    var alignment: Alignment
    var label: String
    
    init(range: Range, alignment: Alignment, toggleAvailable: Binding<Bool>) {
        self._toggleAvailable = toggleAvailable
        
        self.range = range
        self.alignment = alignment
        switch range {
        case .low:
            self.label = "Low"
        case .mid:
            self.label = "Mid"
        case .high:
            self.label = "High"
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            HStack() {
                Text(label)
                    .font(.subheadline)
            }.frame(height: circleDiameter)
            ZStack() {
                VStack() {
                    activeColorButton()
                    Spacer()
                }
                ColorPickerMenu(range: range, alignment: alignment, togglePicker: { () -> Void in togglePicker() })
                    .offset(y: pickerOffset)
                    .scaleEffect(pickerScale)
                    .animation(.easeOut(duration: 0.2))
            }.frame(height: UIScreen.screenHeight * 0.23)
        }
    }
    
    func activeColorButton() -> some View {
        return Button(action: {() -> Void in togglePicker() }) {
            Circle()
                .fill(colors.activeColor(range: range))
                .frame(width: circleDiameter,
                       height: circleDiameter)
        }
    }
    
    func togglePicker() -> Void {
        if (toggleAvailable || toggled) {
            pickerOffset = pickerOffset == 40.0 ? 0.0 : 40.0
            pickerScale = pickerScale == 1.0 ? 0.0 : 1.0
            toggled.toggle()
            toggleAvailable.toggle()
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()//ColorPicker_Preview_View()
    }
}

struct ColorPicker_Preview_View: View {
    @State private var toggleAvailable: Bool = true
    
    var body: some View {
        ColorPicker(range: .mid, alignment: .center, toggleAvailable: $toggleAvailable)
    }
}

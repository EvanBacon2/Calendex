//
//  ColorPicker.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct ColorPicker: View {
    @EnvironmentObject var colors: Colors
    
    @State var showPicker: Bool
    
    var circleDiameter = Dimensions.BASE_UNIT * 27
    
    var range: Range
    var alignment: Alignment
    var label: String
    
    init(range: Range, alignment: Alignment) {
        self._showPicker = State(initialValue: false)
        
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
                    .foregroundColor(Color.black)
            }.frame(height: circleDiameter)
            ZStack() {
                VStack() {
                    activeColorButton()
                    Spacer()
                }
                if (showPicker) {
                    ColorPickerMenu(range: range, alignment: alignment, showPicker: $showPicker)
                }
            }.frame(height: UIScreen.screenHeight * 0.23)
        }
    }
    
    func activeColorButton() -> some View {
        return Button(action: {() -> Void in showPicker.toggle()}) {
            Circle()
                .fill(colors.getActiveColor(range: range))
                .frame(width: circleDiameter,
                       height: circleDiameter)
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(range: .mid, alignment: .center).environmentObject(Colors())
    }
}

struct ColorPicker_Preview_Provider: View {
    var body: some View {
        ColorPicker(range: .mid, alignment: .center)
    }
}

//
//  DataButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct DataButton: View {
    @EnvironmentObject var colors: Colors
    
    @Binding var selected: String
    
    var label: String
    var buttonWidth = UIScreen.screenHeight * 0.15
    var buttonHeight = UIScreen.screenHeight * 0.06
    var buttonCorner = UIScreen.screenHeight * 0.016
    
    init(_ label: String, selected: Binding<String>) {
        self.label = label
        self._selected = selected
    }
    
    var body: some View {
        Button(action: {
            selected = label
        }) {
            Text(self.label)
                .foregroundColor(selected == label ? Color.white : colors.DARK_GRAY)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                    .fill(selected == label ? colors.ACCENT_COLOR : colors.LIGHT_BLUE_GRAY)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(radius: 6, y: 6))
        }
    }
}

struct DataButton_Previews: PreviewProvider {
    static var previews: some View {
        DataButton_Preview_View()
    }
}

struct DataButton_Preview_View: View {
    @State var selected = "Average"
    
    var body: some View {
        DataButton("test", selected: $selected).environmentObject(Colors())
    }
}

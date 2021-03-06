//
//  DataButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct DataButton: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    @Binding var selected: String
    
    var label: String
    var buttonWidth = UIScreen.screenWidth * 0.26
    var buttonHeight = UIScreen.screenWidth * 0.26 * 0.4
    var buttonCorner: CGFloat = 8
    
    init(_ label: String, selected: Binding<String>) {
        self.label = label
        self._selected = selected
    }
    
    var body: some View {
        Button(action: {
            selected = label
        }) {
            Text(self.label)
                .foregroundColor(selected == label ? Color.white : colors.fillerTextColor(colorScheme))
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                    .fill(selected == label ? AppColors.ACCENT_COLOR : colors.fillerButtonColor(colorScheme))
                    .frame(width: buttonWidth, height: buttonHeight))
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

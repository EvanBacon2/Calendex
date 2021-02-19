//
//  MonthButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct MonthButton: View {
    @EnvironmentObject var colors: Colors
    
    var label: String
    var buttonWidth = UIScreen.screenWidth * 0.125
    var buttonHeight = UIScreen.screenHeight * 0.09
    var buttonCorner = UIScreen.screenHeight * 0.016
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        Button(action: {
        
        }) {
            Text(self.label)
                .foregroundColor(Color.white)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                    .fill(colors.ACCENT_COLOR)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(radius: 6, y: 6))
        }
    }
}

struct MonthButton_Previews: PreviewProvider {
    static var previews: some View {
        MonthButton("Tst").environmentObject(Colors())
    }
}

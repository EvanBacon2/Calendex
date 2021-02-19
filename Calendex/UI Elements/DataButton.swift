//
//  DataButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct DataButton: View {
    @EnvironmentObject var colors: Colors
    
    var label: String
    var buttonWidth = UIScreen.screenHeight * 0.15
    var buttonHeight = UIScreen.screenHeight * 0.06
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
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                    .fill(colors.ACCENT_COLOR)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(radius: 6, y: 6))
        }
    }
}

struct DataButton_Previews: PreviewProvider {
    static var previews: some View {
        DataButton("test").environmentObject(Colors())
    }
}

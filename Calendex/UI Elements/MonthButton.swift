//
//  MonthButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct MonthButton: View {
    @EnvironmentObject var colors: Colors
    
    let label: String
    let year: Int
    let month: Int
    
    var buttonWidth = UIScreen.screenWidth * 0.125
    var buttonHeight = UIScreen.screenHeight * 0.09
    var buttonCorner = UIScreen.screenHeight * 0.016
    
    init(_ label: String, year: Int, month: Int) {
        self.label = label
        self.year = year
        self.month = month
    }
    
    var body: some View {
        NavigationLink(destination: Month(year: year, month: month)) {
            Text(self.label)
                .foregroundColor(Color.white)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                                .fill(colors.getActiveColor(range: .mid))
                    .frame(width: buttonWidth, height: buttonHeight)
                    .shadow(radius: 6, y: 6))
        }
    }
}

struct MonthButton_Previews: PreviewProvider {
    static var previews: some View {
        MonthButton("Mar", year: 2020, month: 3).environmentObject(Colors())
    }
}

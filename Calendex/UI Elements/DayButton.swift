//
//  DayButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButton: View {
    @EnvironmentObject var colors: Colors
    
    var day: Int
    var buttonLength = UIScreen.screenWidth * 0.9 / 9
    var buttonCorner = UIScreen.screenHeight * 0.01
    
    init(_ day: Int) {
        self.day = day
    }
    
    var body: some View {
        NavigationLink(destination: Day(day: day)) {
            Text("\(day)")
                .foregroundColor(Color.white)
                .frame(width: buttonLength, height: buttonLength)
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                                .fill(colors.getActiveColor(range: .mid))
                                    .frame(width: buttonLength, height: buttonLength))
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton(1).environmentObject(Colors())
    }
}

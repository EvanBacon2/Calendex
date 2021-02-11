//
//  DayButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButton: View {
    var day: Int
    var buttonLength = UIScreen.screenWidth * 0.9 / 9
    var buttonCorner = UIScreen.screenHeight * 0.01
    
    init(_ day: Int) {
        self.day = day
    }
    
    var body: some View {
        Button(action: {
        
        }) {
            Text("\(day)")
                .foregroundColor(Color.white)
                .frame(width: buttonLength, height: buttonLength)
                .background(RoundedRectangle(cornerRadius: buttonCorner)
                                .fill(AppColors.MID_2)
                                    .frame(width: buttonLength, height: buttonLength))
        }
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton(1)
    }
}

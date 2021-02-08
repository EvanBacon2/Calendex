//
//  DayButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButton: View {
    var day: Int
    
    init(_ day: Int) {
        self.day = day
    }
    
    var body: some View {
        Button(action: {
        
        }) {
            Text("\(day)")
                .foregroundColor(Color.white)
                .frame(width: 40, height: 50)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(AppColors.MID_2)
                                    .frame(width: UIScreen.screenWidth * 0.9 / 9, height: UIScreen.screenWidth * 0.9 / 9))
        }.frame(width: UIScreen.screenWidth * 0.9 / 9, height: UIScreen.screenWidth * 0.9 / 9)
    }
}

struct DayButton_Previews: PreviewProvider {
    static var previews: some View {
        DayButton(1)
    }
}

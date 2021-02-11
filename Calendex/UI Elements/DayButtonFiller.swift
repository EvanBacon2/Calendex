//
//  DayButtonFiller.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtonFiller: View {
    var buttonLength = UIScreen.screenWidth * 0.9 / 9
    var buttonCorner = UIScreen.screenHeight * 0.01
    
    var body: some View {
        RoundedRectangle(cornerRadius: buttonCorner)
            .fill(Color.white)
            .frame(width: buttonLength, height: buttonLength)
    }
}

struct DayButtonFiller_Previews: PreviewProvider {
    static var previews: some View {
        DayButtonFiller()
    }
}

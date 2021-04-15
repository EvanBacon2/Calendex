//
//  DayButtonFiller.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtonFiller: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    var buttonLength = UIScreen.screenWidth * 0.9 / 9
    var buttonCorner = UIScreen.screenHeight * 0.01
    
    var body: some View {
        RoundedRectangle(cornerRadius: buttonCorner)
            .foregroundColor(colors.boxColor(colorScheme))
            .frame(width: buttonLength, height: buttonLength)
    }
}

struct DayButtonFiller_Previews: PreviewProvider {
    static var previews: some View {
        DayButtonFiller()
    }
}

//
//  DayButtonFiller.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct DayButtonFiller: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .frame(width: UIScreen.screenWidth * 0.9 / 9, height: UIScreen.screenWidth * 0.9 / 9)
    }
}

struct DayButtonFiller_Previews: PreviewProvider {
    static var previews: some View {
        DayButtonFiller()
    }
}

//
//  DayFields.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct DayFields: View {
    var body: some View {
        HStack() {
            Spacer()
            DataField(.MIN, 72)
            Spacer()
            DataField(.AVG, 112)
            Spacer()
            DataField(.MAX, 187)
            Spacer()
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayFields_Previews: PreviewProvider {
    static var previews: some View {
        DayFields()
    }
}

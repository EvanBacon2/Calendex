//
//  DayFields.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct DayFields: View {
    let min: Int
    let max: Int
    let avg: Int
    
    init(min: Int, max: Int, avg: Int) {
        self.min = min
        self.max = max
        self.avg = avg
    }
    
    var body: some View {
        HStack() {
            DataField(.MIN, min)
            Spacer()
            DataField(.AVG, avg)
            Spacer()
            DataField(.MAX, max)
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct DayFields_Previews: PreviewProvider {
    static var previews: some View {
        DayFields(min: 72, max: 173, avg: 114).environmentObject(Colors())
    }
}

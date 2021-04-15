//
//  EmptyTimeBar.swift
//  Calendex
//
//  Created by Evan Bacon on 4/14/21.
//

import SwiftUI

struct EmptyTimeBar: View {
    @EnvironmentObject var colors: Colors
    
    let barWidth =  Dimensions.BASE_UNIT * 2 * 100
    let barHeight = Dimensions.BASE_UNIT * 26
    
    var body: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(colors.DARK_GRAY)
            .frame(width: barWidth, height: barHeight)
    }
}

struct EmptyTimeBar_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTimeBar()
    }
}

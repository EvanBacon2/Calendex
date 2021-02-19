//
//  BgTime.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct BgTime {
    @EnvironmentObject var colors: Colors
    
    let range: Range
    var time: Int
    
    init(_ range: Range, time: Int, colors: EnvironmentObject<Colors>) {
        self._colors = colors
        self.range = range
        self.time = time
    }
    
    func color() -> Color {
        return colors.getActiveColor(range: range)
    }
}



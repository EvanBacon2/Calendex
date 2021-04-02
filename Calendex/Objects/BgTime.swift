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
    
    init(_ range: Range, time: Int) {
        self.range = range
        self.time = time
    }
}



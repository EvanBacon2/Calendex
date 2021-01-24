//
//  BgTime.swift
//  Calendex
//
//  Created by Evan Bacon on 1/19/21.
//

import SwiftUI

struct BgTime {
    let range: Range
    let color: Color
    var time: Int
    
    init(_ range: Range, time: Int) {
        self.range = range
        self.time = time
        if (range == .low) {
            color = AppColors.LOW_2
        } else if (range == .mid) {
            color = AppColors.MID_2
        } else {
            color = AppColors.HIGH_2
        }
    }
}



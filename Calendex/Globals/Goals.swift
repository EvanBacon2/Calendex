//
//  Goals.swift
//  Calendex
//
//  Created by Evan Bacon on 2/11/21.
//

import SwiftUI

class Goals: ObservableObject {
    @Published var lowBgThreshold = 70
    @Published var highBgThreshold = 140
    @Published var TimeInRangeThreshold = 75
    @Published var DeviationThreshold = 30
}

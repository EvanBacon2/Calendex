//
//  AppColors.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct AppColors {
    static let BRAND_COLOR = SwiftUI.Color.init(hue: 162.0 / 360, saturation: 60.0 / 100, brightness: 51.0 / 100)

    static let LIGHT_BLUE_GRAY = SwiftUI.Color.init(hue: 191.0 / 360, saturation: 12.0 / 100, brightness: 90.0 / 100)
    
    static let DARK_GRAY = SwiftUI.UIColor.init(hue: 191.0 / 360, saturation: 5.0 / 100, brightness: 45.0 / 100, alpha: 1.0)
    
    static let LOW_1 = SwiftUI.Color.init(hue: 295.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    static let LOW_2 = SwiftUI.Color.init(hue: 270.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    static let LOW_3 = SwiftUI.Color.init(hue: 248.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    
    static let MID_1 = SwiftUI.Color.init(hue: 216.0 / 360, saturation: 55.0 / 100, brightness: 58.0 / 100)
    static let MID_2 = SwiftUI.Color.init(hue: 176.0 / 360, saturation: 49.0 / 100, brightness: 47.0 / 100)
    static let MID_3 = SwiftUI.Color.init(hue: 76.0 / 360, saturation: 49.0 / 100, brightness: 60.0 / 100)
    
    static let HIGH_1 = SwiftUI.Color.init(hue: 54.0 / 360, saturation: 59.0 / 100, brightness: 62.0 / 100)
    static let HIGH_2 = SwiftUI.Color.init(hue: 43.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    static let HIGH_3 = SwiftUI.Color.init(hue: 25.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    
    static let RANGE_COLOR_OPTIONS = 3
    
    static private let LOW_LIST = [LOW_1, LOW_2, LOW_3]
    static private let MID_LIST = [MID_1, MID_2, MID_3]
    static private let HIGH_LIST = [HIGH_1, HIGH_2, HIGH_3]
    
    static func getColor(range: Range, index: Int) -> Color {
        switch range {
        case .low:
            return LOW_LIST[index]
        case .mid:
            return MID_LIST[index]
        case .high:
            return HIGH_LIST[index]
        }
    }
    
    static var ACTIVE_LOW = LOW_2
    static var ACTIVE_MID = MID_2
    static var ACTIVE_HIGH = HIGH_2
    
    static func getActiveColor(range: Range) -> Color {
        switch range {
        case .low:
            return ACTIVE_LOW
        case .mid:
            return ACTIVE_MID
        case .high:
            return ACTIVE_HIGH
        }
    }
    
    static func setActiveColor(range: Range, newColor: Color) {
        switch range {
        case .low:
            ACTIVE_LOW = newColor
        case .mid:
            ACTIVE_MID = newColor
        case .high:
            ACTIVE_HIGH = newColor
        }
    }
}

//
//  AppColors.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct AppColors {
    static let BRAND_COLOR = SwiftUI.Color.init(hue: 162.0 / 360, saturation: 60.0 / 100, brightness: 51.0 / 100)

    static let LIGHT_BLUE_GRAY = SwiftUI.Color.init(hue: 191.0 / 360, saturation: 20.0 / 100, brightness: 90.0 / 100)
    
    static let DARK_GRAY = SwiftUI.Color.init(hue: 191.0 / 360, saturation: 5.0 / 100, brightness: 45.0 / 100)
    
    static let LOW_1 = SwiftUI.Color.init(hue: 295.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    
    static let LOW_2 = SwiftUI.Color.init(hue: 270.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    
    static let LOW_3 = SwiftUI.Color.init(hue: 270.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    
    static let MID_1 = SwiftUI.Color.init(hue: 216.0 / 360, saturation: 55.0 / 100, brightness: 58.0 / 100)
    
    static let MID_2 = SwiftUI.Color.init(hue: 176.0 / 360, saturation: 49.0 / 100, brightness: 47.0 / 100)
    
    static let MID_3 = SwiftUI.Color.init(hue: 76.0 / 360, saturation: 49.0 / 100, brightness: 60.0 / 100)
    
    static let HIGH_1 = SwiftUI.Color.init(hue: 54.0 / 360, saturation: 59.0 / 100, brightness: 62.0 / 100)
    
    static let HIGH_2 = SwiftUI.Color.init(hue: 43.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    
    static let HIGH_3 = SwiftUI.Color.init(hue: 25.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    
    static func getColorForRange(range: Range) -> Color {
        switch range {
        case .low:
            return LOW_2
        case .mid:
            return MID_2
        case .high:
            return HIGH_2
        }
    }
}

//
//  Colors.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

class Colors: ObservableObject {
    let ACCENT_COLOR = SwiftUI.Color.init(hue: 162.0 / 360, saturation: 60.0 / 100, brightness: 51.0 / 100)

    let LIGHT_BLUE_GRAY = SwiftUI.Color.init(hue: 191.0 / 360, saturation: 12.0 / 100, brightness: 90.0 / 100)
    
    let DARK_GRAY = SwiftUI.Color.init(hue: 191.0 / 360, saturation: 5.0 / 100, brightness: 45.0 / 100)
    
    let LIGHT_BOX = SwiftUI.Color.init(hue: 213.0 / 360, saturation: 6.0 / 100, brightness: 83.0 / 100)
    let DARK_BOX = SwiftUI.Color.init(hue: 224.0 / 360, saturation: 20.0 / 100, brightness: 17.0 / 100)
    
    private let LOW_1 = SwiftUI.Color.init(hue: 295.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    private let LOW_2 = SwiftUI.Color.init(hue: 270.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    private let LOW_3 = SwiftUI.Color.init(hue: 248.0 / 360, saturation: 47.0 / 100, brightness: 48.0 / 100)
    
    private let MID_1 = SwiftUI.Color.init(hue: 216.0 / 360, saturation: 55.0 / 100, brightness: 58.0 / 100)
    private let MID_2 = SwiftUI.Color.init(hue: 176.0 / 360, saturation: 49.0 / 100, brightness: 47.0 / 100)
    private let MID_3 = SwiftUI.Color.init(hue: 76.0 / 360, saturation: 49.0 / 100, brightness: 60.0 / 100)
    
    private let HIGH_1 = SwiftUI.Color.init(hue: 54.0 / 360, saturation: 59.0 / 100, brightness: 62.0 / 100)
    private let HIGH_2 = SwiftUI.Color.init(hue: 43.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    private let HIGH_3 = SwiftUI.Color.init(hue: 25.0 / 360, saturation: 74.0 / 100, brightness: 61.0 / 100)
    
    let RANGE_COLOR_OPTIONS = 3
    
    private let LOW_LIST: [Color]
    private let MID_LIST: [Color]
    private let HIGH_LIST: [Color]
    
    @Published var ACTIVE_LOW: Color
    @Published var ACTIVE_MID: Color
    @Published var ACTIVE_HIGH: Color
    
    init() {
        self.LOW_LIST = [LOW_1, LOW_2, LOW_3]
        self.MID_LIST = [MID_1, MID_2, MID_3]
        self.HIGH_LIST = [HIGH_1, HIGH_2, HIGH_3]
        
        self.ACTIVE_LOW = LOW_2
        self.ACTIVE_MID = MID_2
        self.ACTIVE_HIGH = HIGH_2
    }
    
    func getColor(range: Range, index: Int) -> Color {
        switch range {
        case .low:
            return LOW_LIST[index]
        case .mid:
            return MID_LIST[index]
        case .high:
            return HIGH_LIST[index]
        }
    }
    
    func getColorOptions(range: Range) -> [Color] {
        switch range {
        case .low:
            return LOW_LIST
        case .mid:
            return MID_LIST
        case .high:
            return HIGH_LIST
        }
    }
    
    func getActiveColor(range: Range) -> Color {
        switch range {
        case .low:
            return ACTIVE_LOW
        case .mid:
            return ACTIVE_MID
        case .high:
            return ACTIVE_HIGH
        }
    }
    
    func setActiveColor(range: Range, newColor: Color) {
        switch range {
        case .low:
            ACTIVE_LOW = newColor
        case .mid:
            ACTIVE_MID = newColor
        case .high:
            ACTIVE_HIGH = newColor
        }
    }
    
    func getBoxColor(_ scheme: ColorScheme) -> Color {
        switch scheme {
            case .light: return LIGHT_BOX
            case .dark: return DARK_BOX
            default: return LIGHT_BOX
        }
    }
}

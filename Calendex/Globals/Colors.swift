//
//  Colors.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

class Colors: ObservableObject {
    private let LOW_LIST: [Color]
    private let MID_LIST: [Color]
    private let HIGH_LIST: [Color]
    
    @Published var ACTIVE_LOW: Color
    @Published var ACTIVE_MID: Color
    @Published var ACTIVE_HIGH: Color
    
    init() {
        self.LOW_LIST = [AppColors.LOW_1, AppColors.LOW_2, AppColors.LOW_3]
        self.MID_LIST = [AppColors.MID_1, AppColors.MID_2, AppColors.MID_3]
        self.HIGH_LIST = [AppColors.HIGH_1, AppColors.HIGH_2, AppColors.HIGH_3]
        
        self.ACTIVE_LOW = AppColors.LOW_2
        self.ACTIVE_MID = AppColors.MID_2
        self.ACTIVE_HIGH = AppColors.HIGH_2
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
    
    func activeColor(range: Range) -> Color {
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
    
    func backgroundColor(_ scheme: ColorScheme) -> Color {
        switch scheme {
            case .light: return AppColors.LIGHT_BACKGROUND
            case .dark: return AppColors.DARK_BACKGROUND
            default: return AppColors.LIGHT_BACKGROUND
        }
    }
    
    func boxColor(_ scheme: ColorScheme) -> Color {
        switch scheme {
            case .light: return AppColors.LIGHT_BOX
            case .dark: return AppColors.DARK_BOX
            default: return AppColors.LIGHT_BOX
        }
    }
    
    func fillerTextColor(_ scheme: ColorScheme) -> Color {
        switch scheme {
            case .light: return AppColors.DARK_GRAY
            case.dark: return AppColors.LIGHT_GRAY
            default: return AppColors.DARK_GRAY
        }
    }
    
    func fillerButtonColor(_ scheme: ColorScheme) -> Color {
        switch scheme {
            case .light: return AppColors.LIGHT_BLUE_GRAY
            case.dark: return AppColors.DARK_BLUE_GRAY
            default: return AppColors.LIGHT_BLUE_GRAY
        }
    }
}

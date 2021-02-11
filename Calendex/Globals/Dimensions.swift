//
//  Dimensions.swift
//  Calendex
//
//  Created by Evan Bacon on 2/8/21.
//

import SwiftUI

struct Dimensions {
    static let BASE_UNIT = UIScreen.screenHeight * 0.002
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

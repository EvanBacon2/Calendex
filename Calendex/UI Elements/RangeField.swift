//
//  RangeField.swift
//  Calendex
//
//  Created by Evan Bacon on 3/31/21.
//

import SwiftUI

enum FieldSize {
    case small
    case medium
    case large
}

struct RangeField: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    let range: Range
    let value: Int
    let size: FieldSize
    let lessThan: String
    
    let activeWscale: CGFloat
    let activeHScale: CGFloat

    let fieldW = UIScreen.screenWidth * 0.2
    let fieldH = UIScreen.screenWidth * 0.09
    let fieldR = UIScreen.screenWidth * 0.015
    
    let ghostW = UIScreen.screenWidth * 0.19
    let ghostH = UIScreen.screenWidth * 0.08
    
    let dividerW = UIScreen.screenWidth * 0.12
    
    let smallWScale: CGFloat = 0.93
    let mediumWScale: CGFloat = 1
    let largeWScale: CGFloat = 1.07
    
    let smallHScale: CGFloat = 0.93
    let mediumHScale: CGFloat = 1
    let largeHScale: CGFloat = 1.07
    
    init(range: Range, value: Int, size: FieldSize, lessThanOne: Bool = false) {
        self.range = range
        self.value = value
        self.size = size
        self.lessThan = lessThanOne ? "<" : ""
        
        switch size {
        case .small:
            self.activeWscale = smallWScale
            self.activeHScale = smallHScale
        case .medium:
            self.activeWscale = mediumWScale
            self.activeHScale = mediumHScale
        case .large:
            self.activeWscale = largeWScale
            self.activeHScale = largeHScale
        }
    }
    
    var body: some View {
        ZStack() {
            fieldBox()
            ghostBox()
            divider()
            Text(lessThan + "\(value)%")
        }.frame(width: fieldW * largeWScale, height: fieldH * activeHScale)
    }
    
    func fieldBox() -> some View {
        return RoundedRectangle(cornerRadius: fieldR,           style: .continuous)
            .frame(width: fieldW * activeWscale,
                   height: fieldH * activeHScale)
            .foregroundColor(colors.activeColor(range: range))
    }
    
    func ghostBox() -> some View {
        return RoundedRectangle(cornerRadius: fieldR, style: .continuous)
            .frame(width: ghostW * activeWscale,
                   height: ghostH * activeHScale)
            .foregroundColor(colors.boxColor(colorScheme))
    }
    
    func divider() -> some View {
        return Rectangle()
            .frame(width: dividerW * activeWscale,
                   height: fieldH * activeHScale)
            .foregroundColor(colors.boxColor(colorScheme))
    }
}

struct RangeField_Previews: PreviewProvider {
    static var previews: some View {
        HStack() {
            RangeField(range: .low, value: 1, size: .medium, lessThanOne: true)
            Spacer().frame(width: UIScreen.screenWidth * 0.06)
            RangeField(range: .mid, value: 72, size: .large)
            Spacer().frame(width: UIScreen.screenWidth * 0.06)
            RangeField(range: .high, value: 27, size: .small)
        }.environmentObject(Colors())
    }
}

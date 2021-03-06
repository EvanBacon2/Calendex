//
//  DataField.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

enum Field: String {
    case MIN = "Min"
    case MAX = "Max"
    case AVG = "Average"
}

struct DataField: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    var data: Field
    var value: Int
    var buttonWidth = UIScreen.screenWidth * 0.28
    var buttonHeight = UIScreen.screenWidth * 0.28 * 0.37
    var buttonCorner: CGFloat = 6
    
    init(_ data: Field, _ value: Int) {
        self.data = data
        self.value = value
    }
    
    var body: some View {
        VStack(spacing: Spacing.SINGLE_SPACE) {
            Text(data.rawValue)
                .foregroundColor(colors.fillerTextColor(colorScheme))
            Text("\(value) ml")
                .foregroundColor(textColor())
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                    .fill(buttonColor())
                    .frame(width: buttonWidth, height: buttonHeight))
        }
    }
    
    func textColor() -> Color {
        return data == .AVG ? AppColors.LIGHT_GRAY : colors.fillerTextColor(colorScheme)
    }
    
    func buttonColor() -> Color {
        return data == .AVG ? colors.activeColor(range: getRange()) : colors.fillerButtonColor(colorScheme)
    }
    
    func getRange() -> Range {
        if (value < goals.lowBgThreshold) {
            return .low
        } else if (value > goals.highBgThreshold) {
            return .high
        } else {
            return .mid
        }
    }
}

struct DataField_Previews: PreviewProvider {
    static var previews: some View {
        DataField(.AVG, 72).environmentObject(Colors())
                           .environmentObject(Goals())
    }
}

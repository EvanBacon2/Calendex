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
        VStack(spacing: UIScreen.screenHeight * 0.002) {
            Text(data.rawValue)
                .foregroundColor(AppColors.DARK_GRAY)
            Text("\(value) ml")
                .foregroundColor(textColor())
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                    .fill(buttonColor())
                    .frame(width: buttonWidth, height: buttonHeight))
        }
    }
    
    func textColor() -> Color {
        return data == .AVG ? AppColors.LIGHT_BLUE_GRAY : AppColors.DARK_GRAY
    }
    
    func buttonColor() -> Color {
        return data == .AVG ? colors.activeColor(range: getRange()) : AppColors.LIGHT_BLUE_GRAY
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

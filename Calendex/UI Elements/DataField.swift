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
    var data: Field
    var value: Int
    var textColor: Color
    var buttonColor: Color
    var buttonWidth = UIScreen.screenHeight * 0.16
    var buttonHeight = UIScreen.screenHeight * 0.06
    var buttonCorner = UIScreen.screenHeight * 0.012
    
    init(_ data: Field, _ value: Int) {
        self.data = data
        self.value = value
        switch data {
        case .MIN, .MAX:
            self.textColor = AppColors.DARK_GRAY
            self.buttonColor = AppColors.LIGHT_BLUE_GRAY
        case .AVG:
            self.textColor = AppColors.LIGHT_BLUE_GRAY
            self.buttonColor = AppColors.MID_2
        }
    }
    
    var body: some View {
        VStack(spacing: UIScreen.screenHeight * 0.002) {
            Text(data.rawValue)
                .foregroundColor(AppColors.DARK_GRAY)
            Text("\(value) ml")
                .foregroundColor(textColor)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                    .fill(buttonColor)
                    .frame(width: buttonWidth, height: buttonHeight))
        }
    }
}

struct DataField_Previews: PreviewProvider {
    static var previews: some View {
        DataField(.AVG, 72)
    }
}

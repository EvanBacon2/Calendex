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
    
    init(_ data: Field, _ value: Int) {
        self.data = data
        self.value = value
        switch data {
        case .MIN:
            self.textColor = AppColors.DARK_GRAY
            self.buttonColor = AppColors.LIGHT_BLUE_GRAY
        case .MAX:
            self.textColor = AppColors.DARK_GRAY
            self.buttonColor = AppColors.LIGHT_BLUE_GRAY
        case .AVG:
            self.textColor = AppColors.LIGHT_BLUE_GRAY
            self.buttonColor = AppColors.MID_2
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text(data.rawValue)
                .foregroundColor(AppColors.DARK_GRAY)
            Text("\(value) ml")
                .foregroundColor(textColor)
                .frame(width: 80, height: 30)
                .background(RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(buttonColor)
                    .frame(width: 80, height: 30))
        }
    }
}

struct DataField_Previews: PreviewProvider {
    static var previews: some View {
        DataField(.AVG, 72)
    }
}

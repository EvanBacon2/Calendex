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
    
    var data: Field
    var value: Int
    var buttonWidth = UIScreen.screenHeight * 0.16
    var buttonHeight = UIScreen.screenHeight * 0.06
    var buttonCorner = UIScreen.screenHeight * 0.012
    
    init(_ data: Field, _ value: Int) {
        self.data = data
        self.value = value
    }
    
    var body: some View {
        VStack(spacing: UIScreen.screenHeight * 0.002) {
            Text(data.rawValue)
                .foregroundColor(colors.DARK_GRAY)
            Text("\(value) ml")
                .foregroundColor(textColor())
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: buttonCorner, style: .continuous)
                    .fill(buttonColor())
                    .frame(width: buttonWidth, height: buttonHeight))
        }
    }
    
    func textColor() -> Color {
        return data == .AVG ? colors.LIGHT_BLUE_GRAY : colors.DARK_GRAY
    }
    
    func buttonColor() -> Color {
        return data == .AVG ? colors.getActiveColor(range: .mid) : colors.LIGHT_BLUE_GRAY
    }
}

struct DataField_Previews: PreviewProvider {
    static var previews: some View {
        DataField(.AVG, 72).environmentObject(Colors())
    }
}

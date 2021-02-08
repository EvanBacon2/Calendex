//
//  MinMaxField.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI

struct MinField: View {
    var min: Int
    
    init(_ min: Int) {
        self.min = min
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text("Min")
                .foregroundColor(AppColors.DARK_GRAY)
            Text("\(min) ml")
                .foregroundColor(AppColors.DARK_GRAY)
                .frame(width: 80, height: 30)
                .background(RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(AppColors.LIGHT_BLUE_GRAY)
                    .frame(width: 80, height: 30))
        }
    }
}

struct MinField_Previews: PreviewProvider {
    static var previews: some View {
        MinField(72)
    }
}

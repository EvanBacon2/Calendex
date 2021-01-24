//
//  MonthButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct MonthButton: View {
    var label: String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        Button(action: {
        
        }) {
            Text(self.label)
                .foregroundColor(Color.white)
                .frame(width: 40, height: 50)
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width: 40, height: 50))
        }
    }
}

struct MonthButton_Previews: PreviewProvider {
    static var previews: some View {
        MonthButton("Tst")
    }
}

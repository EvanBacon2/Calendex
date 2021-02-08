//
//  DataButton.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct DataButton: View {
    var label: String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        Button(action: {
        
        }) {
            Text(self.label)
                .foregroundColor(Color.white)
                .frame(width: 80, height: 35)
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width: 80, height: 35)
                    .shadow(radius: 6, y: 6))
        }
    }
}

struct DataButton_Previews: PreviewProvider {
    static var previews: some View {
        DataButton("test")
    }
}

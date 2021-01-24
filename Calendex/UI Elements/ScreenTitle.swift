//
//  ScreenTitle.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct ScreenTitle: View {
    var title: String
    let simpleGearSymbolConfig = UIImage.SymbolConfiguration(pointSize: 18.0, weight: .black, scale: .large)
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack() {
            Text(self.title)
                .font(.system(size: 24))
                .foregroundColor(AppColors.DARK_GRAY)
            HStack() {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .font(.system(size: 24))
                    .foregroundColor(AppColors.DARK_GRAY)
                Spacer()
                Image(uiImage: UIImage(named: "simple.gear", in: nil, with: simpleGearSymbolConfig)!.withRenderingMode(.alwaysTemplate))
                    .foregroundColor(AppColors.DARK_GRAY)
                    .shadow(color: Color.gray,
                            radius: 4.0,
                            y: 5)
                    .offset(x: -10)
    
            }.frame(width: UIScreen.screenWidth * 0.9)
        }
    }
}

struct ScreenTitle_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTitle("Test")
    }
}

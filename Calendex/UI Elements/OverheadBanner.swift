//
//  OverheadBanner.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct OverheadBanner: View {
    @EnvironmentObject var colors: Colors
    
    var title: String
    let bannerRadius = Dimensions.BASE_UNIT * 35
    let bannerHeight = Dimensions.BASE_UNIT * 30
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack(content: {
            HStack(spacing: -bannerRadius, content: {
                RoundedRectangle(cornerRadius: 0.0)
                    .fill(colors.ACCENT_COLOR)
                    .frame(width: UIScreen.screenWidth * 1.0, height: bannerHeight)
                
            })
            HStack(content: {
                Text(self.title)
                .font(.title3)
                .foregroundColor(Color.white)
                .offset(x: bannerRadius / 2)
                Spacer()
            })
        }).frame(width:  UIScreen.screenWidth * 0.9, height: bannerHeight)
    }
}

func Overhead_Banner(title: String) {
    return
}

struct OverheadBanner_Previews: PreviewProvider {
    static var previews: some View {
        OverheadBanner("Enter Your Dexcom Login").environmentObject(Colors())
    }
}

//
//  OverheadBanner.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct OverheadBanner: View {
    var title: String
    let bannerRadius = Dimensions.BASE_UNIT * 35
    let bannerHeight = Dimensions.BASE_UNIT * 30
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack(content: {
            HStack(spacing: -bannerRadius, content: {
                RoundedRectangle(cornerRadius: bannerRadius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width: bannerRadius + UIScreen.screenWidth * 0.9 / 2, height: bannerHeight)
                Rectangle()
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width:  UIScreen.screenWidth * 0.9 / 2, height: bannerHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            HStack(content: {
                Text(self.title)
                .font(.system(size: 14))
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
        OverheadBanner("Enter Your Dexcom Login")
    }
}

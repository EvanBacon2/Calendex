//
//  OverheadBanner.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct OverheadBanner: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack(content: {
            HStack(spacing: -35, content: {
                RoundedRectangle(cornerRadius: 35, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width: 35 + UIScreen.screenWidth * 0.9 / 2, height: 35)
                RoundedRectangle(cornerRadius: 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(AppColors.BRAND_COLOR)
                    .frame(width:  UIScreen.screenWidth * 0.9 / 2, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            HStack(content: {
                Text(self.title)
                .font(.system(size: 14))
                .foregroundColor(Color.white)
                .offset(x: 17.5)
                Spacer()
            })
                
        }).frame(width:  UIScreen.screenWidth * 0.9, height: 35)
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

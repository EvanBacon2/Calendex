//
//  SliderRuler.swift
//  Calendex
//
//  Created by Evan Bacon on 2/6/21.
//

import SwiftUI

struct SliderRuler: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(){
                Text("60")
                    .font(.system(size: 14))
                    
                Spacer().frame(width: UIScreen.screenWidth * 0.1)
                Text("100")
                    .font(.system(size: 14))
                Spacer()
                Text("200")
                    .font(.system(size: 14))
                Spacer()
                Text("300")
                    .font(.system(size: 14))
                Spacer()
                Text("400")
                    .font(.system(size: 14))
            }
            Rectangle()
                .fill(AppColors.LIGHT_BLUE_GRAY)
                .frame(width: UIScreen.screenWidth * 0.85, height: 1)
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct SliderRuler_Previews: PreviewProvider {
    static var previews: some View {
        SliderRuler()
    }
}

//
//  Settings.swift
//  Calendex
//
//  Created by Evan Bacon on 2/5/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading) {
                VStack() {
                    ScreenTitle("")
                    OverheadBanner("Settings")
                }
                Spacer().frame(height: 15)
                SubBanner("Goals")
                
                VStack(spacing: 0) {
                    Text("Low High Boundries")
                    Spacer().frame(height: UIScreen.screenHeight * 0.01)
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
                        Spacer().frame(height: UIScreen.screenHeight * 0.04)
                        HStack(spacing: 0) {
                            Spacer().frame(width: 10)
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColors.LOW_2)
                                .frame(width: 10, height: 10)
                            Rectangle()
                                .fill(AppColors.LOW_2)
                                .frame(width: UIScreen.screenWidth * 0.1,
                                       height: 10)
                                .offset(x: -5)
                            Rectangle()
                                .fill(AppColors.MID_2)
                                .frame(width: UIScreen.screenWidth * 0.6,
                                       height: 10)
                                .offset(x: -5)
                            Rectangle()
                                .fill(AppColors.HIGH_2)
                                .frame(width: UIScreen.screenWidth * 0.15,
                                       height: 10)
                                .offset(x: -5)
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColors.HIGH_2)
                                .frame(width: 10, height: 10)
                                .offset(x: -10)
                        }
                    }
                }.frame(width: UIScreen.screenWidth * 0.9)
                Spacer()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

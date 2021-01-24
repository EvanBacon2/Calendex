//
//  ContentView.swift
//  Calendex
//
//  Created by Evan Bacon on 12/26/20.
//

import SwiftUI

struct Login: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, content: {
                Spacer().frame(height: UIScreen.screenHeight * 0.05)
                OverheadBanner("Enter Your Dexcom Login Info")
                
                Spacer().frame(height: UIScreen.screenHeight * 0.05)
                
                HStack(content: {
                    Spacer().frame(width: 17.5)
                    VStack(alignment: .leading, content: {
                        Text("Username")
                        TextField("", text: $username)
                            .frame(width: 250, height: 35)
                            .background(RoundedRectangle(cornerRadius: 35, style: .continuous)
                                    .fill(AppColors.LIGHT_BLUE_GRAY)
                                    .frame(width: 250, height: 35))
                
                        Text("Password")
                        TextField("", text: $password)
                            .frame(width: 250, height: 35)
                            .background(RoundedRectangle(cornerRadius: 35, style: .continuous)
                                    .fill(AppColors.LIGHT_BLUE_GRAY)
                                    .frame(width: 250, height: 35))
                    })
                })
                Spacer()
                HStack() {
                    Spacer().frame(width: UIScreen.screenWidth * 0.5)
                    Button(action: {
                        
                    }) {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: 35, style: .continuous)
                                            .fill(AppColors.BRAND_COLOR)
                                            .frame(width: 85, height: 35))
                    }
                }.frame(width: UIScreen.screenWidth * 0.9)
                .offset(y: -35)
        })
        }
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

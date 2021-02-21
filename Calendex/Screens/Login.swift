//
//  ContentView.swift
//  Calendex
//
//  Created by Evan Bacon on 12/26/20.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var colors: Colors
    
    @State var username = ""
    @State var password = ""
    
    let fieldWidth = Dimensions.BASE_UNIT * 217
    let fieldHeight = Dimensions.BASE_UNIT * 30
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .trailing) {
                ScreenHeader(title: "",
                             banner: "Enter Your Dexcom Login Info",
                             bannerOnly: true)
                Spacer().frame(height: UIScreen.screenHeight * 0.05)
                VStack(alignment: .leading) {
                    loginField(title: "Username", field: $username)
                    loginField(title: "Password", field: $password)
                }.padding(.trailing, Dimensions.BASE_UNIT * 17.5)
                Spacer()
                Button(action: {
                        
                }) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 35)
                            .fill(colors.ACCENT_COLOR)
                            .frame(width: Dimensions.BASE_UNIT * 85,
                                   height: fieldHeight))
                }.frame(width: Dimensions.BASE_UNIT * 85,
                        height: fieldHeight)
                .padding(.trailing, Dimensions.BASE_UNIT * 17.5)
                .padding(.bottom, 25)
            }
        }
    }
    
    func loginField(title: String, field: Binding<String>) -> some View {
        return VStack(alignment: .leading) {
                   Text(title)
                   TextField("", text: field)
                       .frame(width: fieldWidth, height: fieldHeight)
                       .background(RoundedRectangle(cornerRadius: fieldHeight)
                       .fill(colors.LIGHT_BLUE_GRAY)
                       .frame(width: fieldWidth, height: fieldHeight))
               }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(Colors())
    }
}

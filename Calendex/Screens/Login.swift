//
//  Login.swift
//  Calendex
//
//  Created by Evan Bacon on 3/6/21.
//

import SwiftUI
import PromiseKit

struct Login: View {
    @Environment(\.managedObjectContext) var coreContext
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    let fieldWidth = Dimensions.BASE_UNIT * 85
    let fieldHeight = Dimensions.BASE_UNIT * 30
    
    var body: some View {
        if (viewModel.authFlag) {
            signInButton()
        } else if (viewModel.accessFlag) {
            Loading()
        } else if (viewModel.finishFlag) {
            Year(year: 2016)
        } else {
            EmptyView()
        }
    }
    
    func signInButton() -> some View {
        return VStack() {
            Text("Please login with your Dexcom Info")
            Spacer().frame(height: UIScreen.screenHeight * 0.05)
            Button {
                viewModel.signIn()
            } label: {
                Text("Login")
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 35)
                        .fill(colors.ACCENT_COLOR)
                        .frame(width: fieldWidth,
                               height: fieldHeight))
            }.frame(width: fieldWidth,
                    height: fieldHeight)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(Colors())
               .environmentObject(Goals())
    }
}

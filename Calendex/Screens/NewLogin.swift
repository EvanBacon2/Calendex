//
//  NewLogin.swift
//  Calendex
//
//  Created by Evan Bacon on 3/6/21.
//

import SwiftUI
import PromiseKit

struct NewLogin: View {
    @Environment(\.managedObjectContext) var coreContext
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel = SignInViewModel()
    
    @State var userRange: DataRange? = nil
    @State var startLoading: Bool = false
    @State var loadingDone: Bool = false
    
    let fieldWidth = Dimensions.BASE_UNIT * 27
    let fieldHeight = Dimensions.BASE_UNIT * 30
    
    var body: some View {
        if (!startLoading && !loadingDone) {
            VStack() {
                Text("Please login with your Dexcom Info")
                Spacer().frame(height: UIScreen.screenHeight * 0.05)
                Button {
                    firstly {
                        viewModel.signIn()
                    }.done { range in
                        self.userRange = range
                        self.startLoading = true
                    }.catch { error in
                        print(error)
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 35)
                            .fill(colors.ACCENT_COLOR)
                            .frame(width: Dimensions.BASE_UNIT * 85,
                                   height: fieldHeight))
                }.frame(width: Dimensions.BASE_UNIT * 85,
                        height: fieldHeight)
            }
        } else if (startLoading && !loadingDone) {
            Loading(userRange: userRange, loadingDone: $loadingDone)
        } else {
            Year(year: 2016)
        }
    }
}

struct NewLogin_Previews: PreviewProvider {
    static var previews: some View {
        NewLogin().environmentObject(Colors())
                  .environmentObject(Goals())
    }
}

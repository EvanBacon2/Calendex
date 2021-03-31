//
//  Loading.swift
//  Calendex
//
//  Created by Evan Bacon on 3/25/21.
//

import SwiftUI
import PromiseKit

struct Loading: View {
    @EnvironmentObject var goals: Goals
    
    @Binding private var loadingDone: Bool
    
    let userRange: DataRange?
    
    init(userRange: DataRange?, loadingDone: Binding<Bool>) {
        self.userRange = userRange
        self._loadingDone = loadingDone
    }
    
    var body: some View {
        VStack() {
            Text("Loading")
            load()
        }
    }
    
    func load() -> some View {
        firstly {
            BSSetup.populateDataBase(dataRange: self.userRange!,
                                     lowBound: goals.lowBgThreshold,
                                     highBound: goals.highBgThreshold)
        }.done { res in
            loadingDone = true
        }.catch { error in
            print(error)
        }
        return EmptyView()
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

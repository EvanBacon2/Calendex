//
//  Month.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Month: View {
    @EnvironmentObject var goals: Goals
    
    let viewModel: MonthViewModel
    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    let year: Int
    let month: Int
    let months: [String]

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        self.months = ["January", "Febuary", "March",
                       "April", "May", "June",
                       "July", "August", "September",
                       "October", "November", "December"]
        
        self.viewModel = MonthViewModel(year: year, month: month)
        
        self._activeTab = State(wrappedValue: month - viewModel.startMonth())
    }
    
    var body: some View {
            VStack(spacing: 0) {
                OverheadBanner(months[viewModel.startMonth() + activeTab - 1])
                TabView(selection: $activeTab) {
                    ForEach(0..<viewModel.nMonths()) { i in
                        ScrollView {
                            MonthInfo(year: self.year, month: viewModel.startMonth() + i)
                        }
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                settingsLink()
            }.navigationBarTitle("\(month)", displayMode: .inline)
             .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(), isActive: $settingsActive) { EmptyView() }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        Month(year: 2025, month: 7)
            .environmentObject(Colors())
            .environmentObject(Goals())
    }
}

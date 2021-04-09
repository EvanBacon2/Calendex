//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    @EnvironmentObject var goals: Goals
    
    let viewModel: DayViewModel
    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    let blockSpace = UIScreen.screenHeight * 0.02
    
    let year: Int
    let month: Int
    let day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.viewModel = DayViewModel(year: year, month: month, day: day)
        self._activeTab = State(wrappedValue: day - viewModel.startDay())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("\(viewModel.startDay() + activeTab)")
            TabView(selection: $activeTab) {
                ForEach(0..<viewModel.nDays()) { i in
                    ScrollView {
                        DayInfo(year: self.year, month: self.month, day: viewModel.startDay() + i)
                    }
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            settingsLink()
        }.navigationBarTitle("\(day)", displayMode: .inline)
         .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(), isActive: $settingsActive) {
            EmptyView()
        }
    }
}

struct Day_Previews: PreviewProvider {
    static var previews: some View {
        //Day(day: 12).environmentObject(Colors())
                    //.environmentObject(Goals())
        EmptyView()
    }
}

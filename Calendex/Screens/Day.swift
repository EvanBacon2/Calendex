//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    let viewModel: DayViewModel
    
    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    let year: Int
    let month: Int
    let day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.viewModel = DayViewModel(year: year, month: month, day: day)
        self._activeTab = State(wrappedValue: day)
    }
    
    var swipe: some Gesture {
        DragGesture(minimumDistance: 30.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                
                if value.translation.width > 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab > self.viewModel.startDay() ? activeTab - 1 : activeTab
                    print("left swipe")
                }
                else if value.translation.width < 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab < self.viewModel.endDay() ? activeTab + 1 : activeTab
                    print("right swipe")
                }
                else {
                    print("no clue")
                }
            }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("\(activeTab)")
            ScrollView {
                DayInfo(year: self.year, month: self.month, day: activeTab)
                    .onTapGesture { }
                    .gesture(swipe)
            }
            settingsLink()
        }.navigationBarTitle("", displayMode: .inline)
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

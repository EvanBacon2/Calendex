//
//  DateShell.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import SwiftUI

struct DateShell: View {
    let viewModel: DateShellViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors

    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    private let year: Int
    private let month: Int
    private let day: Int
    private let dateType: DateType
    
    private enum DateType {
        case year
        case month
        case day
    }
    
    init() {
        self.viewModel = YearViewModel()
        
        self.year = viewModel.startDate()
        self.month = -1
        self.day = -1
        self.dateType = .year
        
        self._activeTab = State(wrappedValue: viewModel.startDate())
    }
    
    init(year: Int = -1, month: Int = -1, day: Int = -1) {
        self.year = year
        self.month = month
        self.day = day
        
        if month == -1 && day == -1 {
            self.dateType = .year
            self._activeTab = State(wrappedValue: year)
        } else if day == -1 {
            self.dateType = .month
            self._activeTab = State(wrappedValue: month)
        } else {
            self.dateType = .day
            self._activeTab = State(wrappedValue: day)
        }
        
        switch self.dateType {
            case .day: self.viewModel = DayViewModel(year: year, month: month, day: day)
            case .month: self.viewModel = MonthViewModel(year: year, month: month)
            case .year: self.viewModel = YearViewModel()
        }
    }
    
    var swipe: some Gesture {
        DragGesture(minimumDistance: 20.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                
                if value.translation.width > 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab > viewModel.startDate() ? activeTab - 1 : activeTab
                    print("left swipe")
                }
                else if value.translation.width < 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab < viewModel.endDate() ? activeTab + 1 : activeTab
                    print("right swipe")
                }
                else {
                    print("no clue")
                }
            }
    }
    
    var body: some View {
        Group {
            if dateType == .year {
                NavigationView {
                    contents().background(colors.backgroundColor(colorScheme))
                }
            } else {
                contents().background(colors.backgroundColor(colorScheme))
            }
        }
    }
    
    func contents() -> some View {
        return VStack(spacing: 0) {
            OverheadBanner(viewModel.getTitle(date: activeTab))
            ScrollView {
                switch dateType {
                    case .year:
                        YearInfo(year: activeTab)
                            .gesture(swipe)
                    case .month:
                        MonthInfo(year: self.year, month: activeTab)
                            .gesture(swipe)
                    case .day:
                        DayInfo(year: self.year, month: self.month, day: activeTab)
                            .gesture(swipe)
                }
            }
            settingsLink()
        }.navigationBarTitle("", displayMode: .inline)
         .navigationBarItems(trailing: SettingsButton($settingsActive))
         .frame(width: UIScreen.screenWidth)
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(), isActive: $settingsActive) { EmptyView() }
    }
}

struct DateShell_Previews: PreviewProvider {
    static var previews: some View {
        //Date()
        EmptyView()
    }
}

extension NavigationLink where Label == EmptyView {
    init?<Value>(
        _ binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) {
        guard let value = binding.wrappedValue else {
            return nil
        }

        let isActive = Binding(
            get: { true },
            set: { newValue in if !newValue { binding.wrappedValue = nil } }
        )

        self.init(destination: destination(value), isActive: isActive, label: EmptyView.init)
    }
}

extension View {
    @ViewBuilder
    func navigate<Value, Destination: View>(
        using binding: Binding<Value?>,
        @ViewBuilder destination: (Value) -> Destination
    ) -> some View {
        background(NavigationLink(binding, destination: destination))
    }
}

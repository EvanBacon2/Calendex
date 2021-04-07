//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: DateInfoViewModel
    @State var settingsActive: Bool = false
    @State var activeTab: Int = 0
    
    init(year: Int) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppColors.DARK_GRAY]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self._viewModel = StateObject(wrappedValue: DateInfoViewModel(year: year))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("\(viewModel.dateInfo!.year)")) {
                        TabView(selection: $activeTab) {
                            YearInfo(year: 2016).tag(0)
                            YearInfo(year: 2017).tag(1)
                            settingsLink()
                        }.tabViewStyle(PageTabViewStyle())
                    }
                    printTab()
                }
            }.navigationBarTitle("Welcome")
             .navigationBarItems(trailing: SettingsButton($settingsActive))
        }
    }
    
    func printTab() -> some View {
        print(activeTab)
        return EmptyView()
    }
    
    func getRange(_ range: Range) -> CGFloat {
        return viewModel.getRange(range, lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(),
                              isActive: $settingsActive) {
            EmptyView()
        }
    }
}

struct Year_Previews: PreviewProvider {
    static var previews: some View {
        return Year(year: 2021).environmentObject(Colors())
                               .environmentObject(Goals())
                               .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension NavigationLink where Label == EmptyView {
    init?<Value>(_ binding: Binding<Value?>, @ViewBuilder destination: (Value) -> Destination) {
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
    func navigate<Value, Destination: View>(using binding: Binding<Value?>, @ViewBuilder destination: (Value) -> Destination
    ) -> some View {
        background(NavigationLink(binding, destination: destination))
    }
}

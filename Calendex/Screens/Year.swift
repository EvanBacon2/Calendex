//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    @FetchRequest var yearInfo: FetchedResults<Date_Info_Entity>
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @StateObject var viewModel: DateInfoViewModel
    @State var settingsActive: Bool = false
    
    init(year: Int) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppColors.DARK_GRAY]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self._yearInfo = FetchRequest(fetchRequest: Fetches.fetchDateInfo(year: year))
        self._viewModel = StateObject(wrappedValue: DateInfoViewModel(year: year))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("\(getYear())")) {
                        TabView {
                            LazyVStack(spacing: 0) {
                                Spacer().frame(height: Spacing.HEADER_MARGIN)
                                MonthSummary(year: getYear())
                                Spacer().frame(height: Spacing.DOUBLE_SPACE)
                                TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                                Spacer().frame(height: Spacing.DOUBLE_SPACE)
                                Distribution(distribution: (yearInfo.first?.date_info?.distribution)!)
                                Spacer()
                                
                            }
                            
                            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                                Spacer().frame(height: Spacing.HEADER_MARGIN)
                                MonthSummary(year: getYear())
                                Spacer().frame(height: Spacing.DOUBLE_SPACE)
                                TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                                Spacer().frame(height: Spacing.DOUBLE_SPACE)
                                Distribution(distribution: (yearInfo.first?.date_info?.distribution)!)
                                Spacer()
                            }
                            
                            settingsLink()
                        }.tabViewStyle(PageTabViewStyle())
                    }
                }
            }.navigationBarTitle("Welcome")
             .navigationBarItems(trailing: SettingsButton($settingsActive))
        }
    }
    
    func getYear() -> Int {
        if (yearInfo.isEmpty) {
            return 0
        } else {
            return (yearInfo.first?.year)!
        }
    }
    
    func getRange(_ range: Range) -> CGFloat {
        return viewModel.getRange(range, lowBound: goals.lowBgThreshold, highBound: goals.highBgThreshold)
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
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

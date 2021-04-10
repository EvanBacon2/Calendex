//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    @FetchRequest var metaData: FetchedResults<Meta_Entity>
    
    @EnvironmentObject var colors: Colors
    @EnvironmentObject var goals: Goals
    
    @State var settingsActive: Bool = false
    @State var activeTab: Int = 0
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppColors.DARK_GRAY]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    
        self._metaData = FetchRequest(fetchRequest: Fetches.fetchMetaData())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("\(metaData.first!.startYear + activeTab)")) {
                        TabView(selection: $activeTab) {
                            ForEach(0..<nYears()) { i in
                                YearInfo(year: metaData.first!.startYear + i).tag(i)
                            }
                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
                settingsLink()
            }.navigationBarTitle("Welcome")
             .navigationBarItems(trailing: SettingsButton($settingsActive))
        }
    }
    
    func nYears() -> Int {
        return (metaData.first!.endYear - metaData.first!.startYear) + 1
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
        return Year().environmentObject(Colors())
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

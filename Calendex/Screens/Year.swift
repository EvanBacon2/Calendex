//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    @FetchRequest var metaData: FetchedResults<Meta_Entity>
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    init() {
        //UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(AppColors.DARK_GRAY)]
        //UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    
        self._metaData = FetchRequest(fetchRequest: Fetches.fetchMetaData())
        self._activeTab = State(wrappedValue: 2015)
    }
    
    var swipe: some Gesture {
        DragGesture(minimumDistance: 20.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                
                if value.translation.width > 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab > self.metaData.first!.startYear ? activeTab - 1 : activeTab
                    print("left swipe")
                }
                else if value.translation.width < 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab < self.metaData.first!.endYear ? activeTab + 1 : activeTab
                    print("right swipe")
                }
                else {
                    print("no clue")
                }
            }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("\(activeTab)")) {
                        YearInfo(year: activeTab)
                            .onTapGesture { }
                            .gesture(swipe)
                    }
                }
                settingsLink()
            }.navigationBarTitle("", displayMode: .inline)
             .navigationBarItems(trailing: SettingsButton($settingsActive))
             .background(colors.backgroundColor(colorScheme))
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

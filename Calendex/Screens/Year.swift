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
    
    @State var settingsActive: Bool = false
    
    init(year: Int) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppColors.DARK_GRAY]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self._yearInfo = FetchRequest(fetchRequest: Fetches.fetchDateInfo(year: year))
    }
    
    var body: some View {
        NavigationView {
            ScrollView() {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("\(getYear())")) {
                        Spacer().frame(height: Spacing.HEADER_MARGIN)
                        MonthSummary(year: getYear())
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        Distribution(distribution: (yearInfo.first?.date_info?.distribution)!)
                        Spacer()
                    }
                }
                settingsLink()
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
        if (yearInfo.isEmpty) {
            return 0
        } else {
            let dis = yearInfo.first?.info?.distribution
            switch range {
            case .low:
                return dis![0..<thToI(goals.lowBgThreshold)].reduce(0, { sum, val in sum + val.value }) * 100
            case .mid:
                return dis![thToI(goals.lowBgThreshold)..<thToI(goals.highBgThreshold)].reduce(0, { sum, val in sum + val.value }) * 100
            case .high:
                return dis![thToI(goals.highBgThreshold)..<dis!.count].reduce(0, { sum, val in sum + val.value }) * 100
            }
        }
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

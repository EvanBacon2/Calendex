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
                        StandardDeviation(distribution: (yearInfo.first?.date_info?.distribution)!)
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
    
    func getRange(_ range: Range) -> Int {
        if (yearInfo.isEmpty) {
            return 0
        } else {
            let tir = yearInfo.first?.info?.timeInRange
            switch range {
            case .low:
                return Int(tir!.lowTime)
            case .mid:
                return Int(tir!.midTime)
            case .high:
                return Int(tir!.highTime)
            }
        }
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
    }
}

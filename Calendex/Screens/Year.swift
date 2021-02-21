//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    @EnvironmentObject var colors: Colors
    
    @State var titleDisplayMode: NavigationBarItem.TitleDisplayMode = .large
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppColors.DARK_GRAY]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
            ScrollView() {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: OverheadBanner("2020")) {
                        Spacer().frame(height: Spacing.HEADER_MARGIN)
                        MonthSummary(year: 2020)
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        TimeInRange(low: 8, mid: 57, high: 35)
                        Spacer().frame(height: Spacing.DOUBLE_SPACE)
                        StandardDeviation()
                        Spacer()
                    }
                }
            }.navigationBarTitle("Welcome")//, displayMode: titleDisplay(scrollPos: geometry.frame(in: .global).minY))
            .navigationBarItems(trailing: SettingsButton())
            }
        }
    }
    
    func titleDisplay(scrollPos: CGFloat) -> NavigationBarItem.TitleDisplayMode {
        if (titleDisplayMode == .large) {
            titleDisplayMode = scrollPos == 64.0 ? .inline : .large
            return titleDisplayMode
        } else {
            return titleDisplayMode
        }
    }
}

struct Year_Previews: PreviewProvider {
    static var previews: some View {
        Year().environmentObject(Colors())
              .environmentObject(Goals())
    }
}

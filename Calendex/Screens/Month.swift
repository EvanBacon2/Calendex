//
//  Month.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Month: View {
    @EnvironmentObject var goals: Goals
    
    @State var settingsActive: Bool = false
    
    let year: Int
    let month: Int
    let months: [String]
    
    let monthInfo: Date_Info_Entity

    init(year: Int, month: Int, monthInfo: Date_Info_Entity) {
        self.year = year
        self.month = month
        self.months = ["January", "Febuary", "March",
                       "April", "May", "June",
                       "July", "August", "September",
                       "October", "November", "December"]
        
        self.monthInfo = monthInfo
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner(months[month-1])
            ScrollView {
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                VStack(spacing: 0) {
                    DaySummary(year: year, month: month)
                    Spacer().frame(height: Spacing.TRIPLE_SPACE)
                    TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    Distribution(distribution: (monthInfo.date_info?.distribution)!)
                }.frame(width: UIScreen.screenWidth)
            }
            settingsLink()
        }.navigationBarTitle("Month", displayMode: .inline)
        .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func getRange(_ range: Range) -> CGFloat {
        let dis = monthInfo.info?.distribution
        switch range {
            case .low:
            return dis![0..<thToI(goals.lowBgThreshold)].reduce(0, { sum, val in sum + val.value }) * 100
        case .mid:
            return dis![thToI(goals.lowBgThreshold)..<thToI(goals.highBgThreshold)].reduce(0, { sum, val in sum + val.value }) * 100
        case .high:
            return dis![thToI(goals.highBgThreshold)..<dis!.count].reduce(0, { sum, val in sum + val.value }) * 100
        }
    }
    
    func thToI(_ threshold: Int) -> Int {
        return (threshold / 10) - 4
    }
    
    func settingsLink() -> NavigationLink<EmptyView, Settings> {
        return NavigationLink(destination: Settings(), isActive: $settingsActive) { EmptyView() }
    }
}

struct Month_Previews: PreviewProvider {
    static var previews: some View {
        //Month(year: 2025, month: 7).environmentObject(Colors()).environmentObject(Goals())
        EmptyView()
    }
}

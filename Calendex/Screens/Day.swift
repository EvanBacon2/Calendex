//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    @FetchRequest var dayInfo: FetchedResults<Date_Info_Entity>
    
    @EnvironmentObject var goals: Goals
    
    @State var settingsActive: Bool = false
    
    let blockSpace = UIScreen.screenHeight * 0.02
    
    let day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.day = day
        self._dayInfo = FetchRequest(fetchRequest: Fetches.fetchDateInfo(year: year, month: month, day: day))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("\(day)")
            ScrollView {
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                VStack(spacing: 0) {
                    DayChart(day: dayInfo.first!)
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    DayQuickData(min: dayInfo.first!.info?.measures?.min ?? -1,
                                 max: dayInfo.first!.info?.measures?.max ?? -1,
                                 avg: Int(dayInfo.first!.info?.measures?.mean ?? -1.0))
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    Distribution(distribution: (dayInfo.first!.date_info?.distribution)!)
                }.frame(width: UIScreen.screenWidth)
            }
            settingsLink()
        }.navigationTitle("\(day)")
        .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func getRange(_ range: Range) -> CGFloat {
        let dis = dayInfo.first!.info?.distribution
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

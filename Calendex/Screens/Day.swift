//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    @EnvironmentObject var goals: Goals
    
    @State var settingsActive: Bool = false
    
    let blockSpace = UIScreen.screenHeight * 0.02
    
    let day: Int
    
    let dayInfo: Date_Info_Entity
    
    init(day: Int, dayInfo: Date_Info_Entity) {
        self.day = day
        self.dayInfo = dayInfo
    }
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("\(day)")
            ScrollView {
                Spacer().frame(height: Spacing.HEADER_MARGIN)
                VStack(spacing: 0) {
                    DayChart(day: dayInfo)
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    DayQuickData(min: dayInfo.info?.measures?.min ?? -1,
                                 max: dayInfo.info?.measures?.max ?? -1,
                                 avg: Int(dayInfo.info?.measures?.mean ?? -1.0))
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    TimeInRange(low: getRange(.low), mid: getRange(.mid), high: getRange(.high))
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    Distribution(distribution: (dayInfo.date_info?.distribution)!)
                }.frame(width: UIScreen.screenWidth)
            }
            settingsLink()
        }.navigationTitle("\(day)")
        .navigationBarItems(trailing: SettingsButton($settingsActive))
    }
    
    func getRange(_ range: Range) -> CGFloat {
        let dis = dayInfo.info?.distribution
        /*print("lowTime: \(tir!.lowTime)")
        print("midTime: \(tir!.midTime)")
        print("highTime: \(tir!.highTime)")*/
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

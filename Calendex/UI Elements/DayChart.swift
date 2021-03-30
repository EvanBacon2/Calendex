//
//  DayChart.swift
//  Calendex
//
//  Created by Evan Bacon on 2/1/21.
//

import SwiftUI
import PromiseKit

struct DayChart: View {
    @EnvironmentObject var goals: Goals
    
    @State private var points: [(Int, Double)] = []
    
    let day: Date
    
    init(day: Date_Info_Entity) {
        var cal = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        self.day = cal.date(from: DateComponents(year: day.year,
                                                 month: day.month,
                                                 day: day.day))!
        print("day day day ssss\(self.day)")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            getPoints()
            ZStack() {
                DayChartBackground(lowCutoff: goals.lowBgThreshold,
                                   highCutoff: goals.highBgThreshold)
                PointGraph(points)
            }
        }.frame(width: UIScreen.screenWidth * 0.9)
    }
    
    func getPoints() -> some View {
        let cal = Calendar.current
        let dayEnd = cal.date(byAdding: .day, value: 1, to: self.day)!
        let dayLength = dayEnd.timeIntervalSince(self.day)
        firstly {
            EgvRequest.call(startDate: self.day, endDate: dayEnd)
        }.done { egvs in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            self.points = egvs.egvs.map {
                (Int($0.value),
                 formatter.date(from: $0.systemTime)!.timeIntervalSince(self.day) / dayLength)
            }
        }.catch { error in
            print(error)
        }
        
        return EmptyView()
    }
}

struct DayChart_Previews: PreviewProvider {
    static var previews: some View {
        /*DayChart().environmentObject(Colors())
                  .environmentObject(Goals())*/
        EmptyView()
    }
}

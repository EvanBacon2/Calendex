//
//  SignInViewModel.swift
//  Calendex
//
//  Created by Evan Bacon on 3/6/21.
//

import SwiftUI
import AuthenticationServices
import PromiseKit
import UIKit
import CoreData
import Foundation

class SignInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    //@Environment(\.managedObjectContext) var coreContext
    
    let coreContext = PersistenceController.shared.container.viewContext
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn() -> Promise<DataRange> {
        return Promise { seal in
            firstly {
                SignInRequest.call(context: self)
            }.then { authCode in
                TokenRequest.call(authCode: authCode)
            }.done { token in
                Token.acquired = Date()
                Token.accessToken = token
            }.then {
                DataRangeRequest.call(token: Token.accessToken!.access_token)
            }.done { range in
                seal.fulfill(range)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func populateDataBase(dataRange: DataRange, lowBound: Int, highBound: Int) -> Promise<Bool> {
        return Promise { seal in
            var cal = Calendar.current
            cal.timeZone = TimeZone(identifier: "UTC")!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            var startDate = formatter.date(from: dataRange.egvs!.start.systemTime)!
            var endDate = formatter.date(from: dataRange.egvs!.end.systemTime)!
            let startComp = cal.dateComponents([.day, .month, .year], from: startDate)
            let endComp = cal.dateComponents([.day, .month, .year], from: endDate)
            startDate = cal.date(from: startComp)!
            endDate = cal.date(from: endComp)!
            
            var dates: [Date] = []
            
            var currDate = startDate
            while (currDate <= endDate) {
                dates.append(currDate)
                currDate = cal.date(byAdding: .day, value: 1, to: currDate)!
            }
            
            when(fulfilled: dates.map { DateInfoRequest.call(token: Token.accessToken!.access_token,
                                                             startDate: $0,
                                                             endDate: cal.date(byAdding: .day, value: 1, to: $0)!,
                                                             lowBound: lowBound,
                                                             highBound: highBound)
            }).done { results in
                for res in results {
                    self.createDay(day: cal.dateComponents([.day, .month, .year], from: res.0),
                                   stats: res.1,
                                   egvs: res.2)
                }
                
                var currMonth = startDate
                while (currMonth <= endDate) {
                    self.createMonth(month: cal.dateComponents([.month, .year], from: currMonth))
                    currMonth = cal.date(byAdding: .month, value: 1, to: currMonth)!
                }
                
                var currYear = startDate
                while (currYear <= endDate) {
                    self.createYear(year: cal.dateComponents([.year], from: currYear))
                    currYear = cal.date(byAdding: .year, value: 1, to: currYear)!
                }
                
                seal.fulfill(true)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func createDay(day: DateComponents, stats: Stats, egvs: Egvs) {
        let dayEntity = Date_Info_Entity(context: self.coreContext)
        dayEntity.year_attr = Int32(day.year!)
        dayEntity.month_attr = Int32(day.month!)
        dayEntity.day_attr = Int32(day.day!)
        dayEntity.entries_attr = Int32(stats.nValues)
        dayEntity.date_info = Bg_Info_Entity(context: self.coreContext)
        dayEntity.date_info?.info_mea = Measures_Entity(context: self.coreContext)
        dayEntity.date_info?.info_tir = TimeInRange_Entity(context: self.coreContext)
        dayEntity.date_info?.info_dis = Distribution_Entity(context: self.coreContext)
            
        if (stats.nValues > 0) {
            let infoEntity = dayEntity.date_info!
            
            infoEntity.info_mea?.mean_attr = Float(stats.mean)
            infoEntity.info_mea?.stdDeviation_attr = Float(stats.stdDev)
            infoEntity.info_mea?.min_attr = Int32(stats.min)
            infoEntity.info_mea?.max_attr = Int32(stats.max)
                    
            infoEntity.info_tir?.lowTime_attr = Float(round(stats.percentUrgentLow + stats.percentBelowRange))
            infoEntity.info_tir?.midTime_attr = Float(round(stats.percentWithinRange))
            infoEntity.info_tir?.highTime_attr = Float(round(stats.percentAboveRange))
            
            var distribution = Array(repeating: 0, count: 36)
        
            for egv in egvs.egvs {
                var val = egv.value
                val = val < 40 ? val + 1 : val
                val = val > 400 ? val - 1 : val
                val /= 10.0
                var valRange = Int(floor(val))
                valRange = valRange == 36 ? valRange - 1 : valRange
                distribution[valRange - 4] += 1
            }
                
            let distSum: Float = Float(distribution.reduce(0, +))
            let distRanges = (4...39).map { range -> DistributionRange_Entity in
                let rangeEntity = DistributionRange_Entity(context: self.coreContext)
                rangeEntity.range_attr = Int32(range * 10)
                rangeEntity.value_attr = Float(distribution[range - 4]) / distSum
                return rangeEntity
            }
            
            for distRange in distRanges {
                dayEntity.date_info?.info_dis?.addToDis_disRange(distRange)
            }
        }
        //print(dayEntity)
        //print(dayEntity.date_info!.info_dis!.distribution)
    }
    
    func createMonth(month: DateComponents) {
        let monthEntity = Date_Info_Entity(context: self.coreContext)
        monthEntity.year_attr = Int32(month.year!)
        monthEntity.month_attr = Int32(month.month!)
        monthEntity.day_attr = -1
        monthEntity.date_info = Bg_Info_Entity(context: self.coreContext)
        monthEntity.date_info?.info_mea = Measures_Entity(context: self.coreContext)
        monthEntity.date_info?.info_tir = TimeInRange_Entity(context: self.coreContext)
        monthEntity.date_info?.info_dis = Distribution_Entity(context: self.coreContext)
        
        var monthDays: [Date_Info_Entity] = []
        
        do {
            monthDays = try self.coreContext.fetch(Fetches.fetchDaysInMonth(year: month.year!, month: month.month!))
        } catch {
            print(error)
        }
        
        var nEntries = 0
        var min = Int(Int32.max)
        var max = Int(Int32.min)
        var mean: CGFloat = 0.0
        var stdDev: CGFloat = 0.0
        var lowTime: CGFloat = 0.0
        var midTime: CGFloat = 0.0
        var highTime: CGFloat = 0.0
        var distribution: [CGFloat] = Array(repeating: 0, count: 36)
        
        for day in monthDays {
            if let dayInfo = day.date_info {
                nEntries += day.entries
                min = dayInfo.info_mea!.min < min ? dayInfo.info_mea!.min : min
                max = dayInfo.info_mea!.max > max ? dayInfo.info_mea!.max : max
                mean += dayInfo.info_mea!.mean * CGFloat(day.entries)
                stdDev += pow(dayInfo.info_mea!.stdDeviation * CGFloat(day.entries), 2)
                lowTime += dayInfo.info_tir!.lowTime
                midTime += dayInfo.info_tir!.midTime
                highTime += dayInfo.info_tir!.highTime
                distribution = zip(distribution, dayInfo.info_dis!.distribution).map { $0 + $1.value }
            }
        }
        
        mean /= CGFloat(nEntries)
        stdDev = sqrt(stdDev / CGFloat(nEntries))
        let timeSum = lowTime + midTime + highTime
        lowTime /= timeSum
        midTime /= timeSum
        highTime /= timeSum
        let distSum = distribution.reduce(0, +)
        distribution = distribution.map { $0 / distSum}
        
        monthEntity.entries_attr = Int32(nEntries)
        
        let info = monthEntity.date_info!
        let measures = info.info_mea!
        let time = info.info_tir!
        let dist = info.info_dis!
        
        measures.mean_attr = Float(mean)
        measures.stdDeviation_attr = Float(stdDev)
        measures.min_attr = Int32(min)
        measures.max_attr = Int32(max)
        
        time.lowTime_attr = Float(lowTime)
        time.midTime_attr = Float(midTime)
        time.highTime_attr = Float(highTime)
        
        for i in (0..<distribution.count) {
            let range = DistributionRange_Entity(context: self.coreContext)
            range.range_attr = Int32((i + 4) * 10)
            range.value_attr = Float(distribution[i])
            dist.addToDis_disRange(range)
        }
        
        //print(monthEntity)
        //print(monthEntity.date_info!.info_dis!.distribution)
    }
    
    func createYear(year: DateComponents) {
        let yearEntity = Date_Info_Entity(context: self.coreContext)
        yearEntity.year_attr = Int32(year.year!)
        yearEntity.month_attr = -1
        yearEntity.day_attr = -1
        yearEntity.date_info = Bg_Info_Entity(context: self.coreContext)
        yearEntity.date_info?.info_mea = Measures_Entity(context: self.coreContext)
        yearEntity.date_info?.info_tir = TimeInRange_Entity(context: self.coreContext)
        yearEntity.date_info?.info_dis = Distribution_Entity(context: self.coreContext)
        
        var yearMonths: [Date_Info_Entity] = []
        
        do {
            yearMonths = try self.coreContext.fetch(Fetches.fetchMonthsInYear(year: year.year!))
        } catch {
            print(error)
        }
        
        var nEntries = 0
        var min = Int(Int32.max)
        var max = Int(Int32.min)
        var mean: CGFloat = 0.0
        var stdDev: CGFloat = 0.0
        var lowTime: CGFloat = 0.0
        var midTime: CGFloat = 0.0
        var highTime: CGFloat = 0.0
        var distribution: [CGFloat] = Array(repeating: 0, count: 36)
        
        for month in yearMonths {
            if let monthInfo = month.date_info {
                nEntries += month.entries
                min = monthInfo.info_mea!.min < min ? monthInfo.info_mea!.min : min
                max = monthInfo.info_mea!.max > max ? monthInfo.info_mea!.max : max
                mean += monthInfo.info_mea!.mean * CGFloat(month.entries)
                stdDev += pow(monthInfo.info_mea!.stdDeviation * CGFloat(month.entries), 2)
                lowTime += monthInfo.info_tir!.lowTime
                midTime += monthInfo.info_tir!.midTime
                highTime += monthInfo.info_tir!.highTime
                distribution = zip(distribution, monthInfo.info_dis!.distribution).map { $0 + $1.value }
            }
        }
        
        mean /= CGFloat(nEntries)
        stdDev = sqrt(stdDev / CGFloat(nEntries))
        let timeSum = lowTime + midTime + highTime
        lowTime /= timeSum
        midTime /= timeSum
        highTime /= timeSum
        let distSum = distribution.reduce(0, +)
        distribution = distribution.map { $0 / distSum}
        
        yearEntity.entries_attr = Int32(nEntries)
        
        let info = yearEntity.date_info!
        let measures = info.info_mea!
        let time = info.info_tir!
        let dist = info.info_dis!
        
        measures.mean_attr = Float(mean)
        measures.stdDeviation_attr = Float(stdDev)
        measures.min_attr = Int32(min)
        measures.max_attr = Int32(max)
        
        time.lowTime_attr = Float(lowTime)
        time.midTime_attr = Float(midTime)
        time.highTime_attr = Float(highTime)
        
        for i in (0..<distribution.count) {
            let range = DistributionRange_Entity(context: self.coreContext)
            range.range_attr = Int32((i + 4) * 10)
            range.value_attr = Float(distribution[i])
            dist.addToDis_disRange(range)
        }
        
        //print(yearEntity)
        //print(yearEntity.date_info!.info_dis!)
    }
}

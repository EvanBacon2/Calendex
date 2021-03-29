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

struct DateInfo {
    var entries: Int = 0
    var mean: Float = 0.0
    var stdDev: Float = 0.0
    var min: Int32 = INT_MAX
    var max: Int32 = -INT_MAX - 1
    var lowTime: Float = 0.0
    var midTime: Float = 0.0
    var highTime: Float = 0.0
    var distribution: [Float] = Array(repeating: 0, count: 36)
}

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
                print("lowBound \(lowBound)")
                print("highBound \(highBound)")
                for res in results {
                    /*self.createDay(day: cal.dateComponents([.day, .month, .year], from: res.0),
                                   stats: res.1,
                                   egvs: res.2)*/
                    /*self.createDayFromEgv(day: cal.dateComponents([.day, .month, .year], from: res.0),
                                          egvs: res.1,
                                          lowBound: lowBound,
                                          highBound: highBound)*/
                    self.createDate(date: cal.dateComponents([.day, .month, .year], from: res.0),
                                    info: self.getInfoFromEgvs(egvs: res.1,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                }
                
                var currMonth = startDate
                while (currMonth <= endDate) {
                    //self.createMonth(month: cal.dateComponents([.month, .year], from: currMonth))
                    let month = cal.dateComponents([.month, .year], from: currMonth)
                    self.createDate(date: month,
                                    info: self.getInfoFromCore(fetchType: "month",
                                                               date: month,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                    currMonth = cal.date(byAdding: .month, value: 1, to: currMonth)!
                }
                
                var currYear = startDate
                while (currYear <= endDate) {
                    //self.createYear(year: cal.dateComponents([.year], from: currYear))
                    let year = cal.dateComponents([.year], from: currYear)
                    self.createDate(date: year,
                                    info: self.getInfoFromCore(fetchType: "year",
                                                               date: year,
                                                               lowBound: lowBound,
                                                               highBound: highBound))
                    currYear = cal.date(byAdding: .year, value: 1, to: currYear)!
                }
                
                seal.fulfill(true)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func createDate(date: DateComponents, info: Bg_Info_Entity) {
        let dateEntity = Date_Info_Entity(context: self.coreContext)
        
        dateEntity.year = date.year ?? -1
        dateEntity.month = date.month ?? -1
        dateEntity.day = date.day ?? -1
        dateEntity.date_info = info
    }
    
    func getInfoFromEgvs(egvs: Egvs, lowBound: Int, highBound: Int) -> Bg_Info_Entity {
        let info = Bg_Info_Entity(context: self.coreContext)
        
        info.info_mea = Measures_Entity(context: self.coreContext)
        info.info_tir = TimeInRange_Entity(context: self.coreContext)
        info.info_dis = Distribution_Entity(context: self.coreContext)
        info.entries = egvs.egvs.count
        
        let measures = info.info_mea!
        let time = info.info_tir!
        let distribution = info.info_dis!
        
        let entries = egvs.egvs.count
        
        info.entries = entries
        measures.mean = CGFloat(egvs.egvs.reduce(0.0, { sum, val in sum + val.value })) / CGFloat(entries)
        measures.stdDeviation = CGFloat(
            sqrt(egvs.egvs.reduce(0.0, { dev, val in pow(val.value - Double(measures.mean), 2) }) / Double(entries)))
        measures.min = egvs.egvs.reduce(Int(INT_MAX), { min, val  in Int(val.value) < min ? Int(val.value) : min })
        measures.max = egvs.egvs.reduce(Int(-INT_MAX - 1), { max, val in Int(val.value) > max ? Int(val.value) : max })
        time.lowTime = CGFloat(egvs.egvs.filter({ $0.value <= Double(lowBound) }).count) / CGFloat(entries)
        time.midTime = CGFloat(egvs.egvs.filter({ $0.value > Double(lowBound) &&
                                                  $0.value < Double(highBound) }).count) / CGFloat(entries)
        time.highTime = CGFloat(egvs.egvs.filter({ $0.value >= Double(highBound) }).count) / CGFloat(entries)
    
        var distCounts = Array(repeating: 0, count: 36)
        
        for egv in egvs.egvs {
            var val = egv.value
            val = val < 40 ? val + 1 : val
            val = val > 400 ? val - 1 : val
            val /= 10.0
            var valRange = Int(floor(val))
            valRange = valRange == 36 ? valRange - 1 : valRange
            distCounts[valRange - 4] += 1
        }
        
        let distSum: Float = Float(distCounts.reduce(0, +))
        let distRanges = (4...39).map { range -> DistributionRange_Entity in
            let rangeEntity = DistributionRange_Entity(context: self.coreContext)
            rangeEntity.range = range * 10
            rangeEntity.value = CGFloat(distCounts[range - 4]) / CGFloat(distSum)
            return rangeEntity
        }
        
        for distRange in distRanges {
            distribution.addToDis_disRange(distRange)
        }
        
        return info
    }
    
    func getInfoFromCore(fetchType: String, date: DateComponents, lowBound: Int, highBound: Int) -> Bg_Info_Entity {
        var fetchRes: [Date_Info_Entity] = []
        
        do {
            if fetchType == "month" {
                fetchRes = try self.coreContext.fetch(Fetches.fetchDaysInMonth(year: date.year!, month: date.month!))
            } else if fetchType == "year" {
                fetchRes = try self.coreContext.fetch(Fetches.fetchMonthsInYear(year: date.year!))
            }
        } catch {
            print(error)
        }
        
        let info = Bg_Info_Entity(context: self.coreContext)
        
        info.info_mea = Measures_Entity(context: self.coreContext)
        info.info_tir = TimeInRange_Entity(context: self.coreContext)
        info.info_dis = Distribution_Entity(context: self.coreContext)
        
        let measures = info.info_mea!
        let time = info.info_tir!
        let distribution = info.info_dis!
    
        var distCounts: [Float] = Array(repeating: 0, count: 36)
        
        for res in fetchRes {
            if let resInfo = res.date_info {
                info.entries += resInfo.entries
                measures.min = resInfo.info_mea!.min < measures.min ? resInfo.info_mea!.min : measures.min
                measures.max = resInfo.info_mea!.max > measures.max ? resInfo.info_mea!.max : measures.max
                measures.mean += resInfo.info_mea!.mean * CGFloat(resInfo.entries)
                measures.stdDeviation += pow(resInfo.info_mea!.stdDeviation * CGFloat(resInfo.entries), 2)
                
                time.lowTime += resInfo.info_tir!.lowTime
                time.midTime += resInfo.info_tir!.midTime
                time.highTime += resInfo.info_tir!.highTime
                
                distCounts = zip(distCounts, resInfo.info_dis!.distribution).map { $0 + Float($1.value) }
            }
        }
        
        measures.mean /= CGFloat(info.entries)
        measures.stdDeviation = sqrt(measures.stdDeviation / CGFloat(info.entries))
        let timeSum = time.lowTime + time.midTime + time.highTime
        time.lowTime /= timeSum
        time.midTime /= timeSum
        time.highTime /= timeSum
        
        let distSum = distCounts.reduce(0, +)
        let distVals = distCounts.map { CGFloat($0 / distSum) }
        let distRanges = (4...39).map { range -> DistributionRange_Entity in
            let rangeEntity = DistributionRange_Entity(context: self.coreContext)
            rangeEntity.range = range * 10
            rangeEntity.value = distVals[range - 4]
            return rangeEntity
        }
        
        for distRange in distRanges {
            distribution.addToDis_disRange(distRange)
        }
        
        return info
    }
    
    func createDayFromEgv(day: DateComponents, egvs: Egvs, lowBound: Int, highBound: Int) {
        let dayEntity = Date_Info_Entity(context: self.coreContext)
        dayEntity.year_attr = Int32(day.year!)
        dayEntity.month_attr = Int32(day.month!)
        dayEntity.day_attr = Int32(day.day!)
        dayEntity.date_info = Bg_Info_Entity(context: self.coreContext)
        dayEntity.date_info?.info_mea = Measures_Entity(context: self.coreContext)
        dayEntity.date_info?.info_tir = TimeInRange_Entity(context: self.coreContext)
        dayEntity.date_info?.info_dis = Distribution_Entity(context: self.coreContext)
        dayEntity.date_info?.entries_attr = Int32(egvs.egvs.count)
        
        let entries = dayEntity.date_info!.entries
        
        let measures = dayEntity.date_info!.info_mea!
        
        measures.mean_attr = Float(egvs.egvs.reduce(0.0, { sum, val in sum + val.value })) / Float(entries)
        measures.stdDeviation_attr = Float(
            sqrt(egvs.egvs.reduce(0.0, { dev, val in pow(val.value - Double(measures.mean), 2) }) / Double(entries)))
        measures.min_attr = egvs.egvs.reduce(INT_MAX, { min, val  in Int32(val.value) < min ? Int32(val.value) : min })
        measures.max_attr = egvs.egvs.reduce(-INT_MAX - 1, { max, val in Int32(val.value) > max ? Int32(val.value) : max })
        
        let time = dayEntity.date_info!.info_tir
        time!.lowTime_attr = Float(egvs.egvs.filter({ $0.value <= Double(lowBound) }).count) / Float(entries)
        time!.midTime_attr = Float(egvs.egvs.filter({ $0.value > Double(lowBound) &&
                                                      $0.value < Double(highBound) }).count) / Float(entries)
        time!.highTime_attr = Float(egvs.egvs.filter({ $0.value >= Double(highBound) }).count) / Float(entries)
        
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
                nEntries += dayInfo.entries
                min = dayInfo.info_mea!.min < min ? dayInfo.info_mea!.min : min
                max = dayInfo.info_mea!.max > max ? dayInfo.info_mea!.max : max
                mean += dayInfo.info_mea!.mean * CGFloat(dayInfo.entries)
                stdDev += pow(dayInfo.info_mea!.stdDeviation * CGFloat(dayInfo.entries), 2)
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
        distribution = distribution.map { $0 / distSum }
        
        monthEntity.date_info!.entries_attr = Int32(nEntries)
        
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
                nEntries += monthInfo.entries
                min = monthInfo.info_mea!.min < min ? monthInfo.info_mea!.min : min
                max = monthInfo.info_mea!.max > max ? monthInfo.info_mea!.max : max
                mean += monthInfo.info_mea!.mean * CGFloat(monthInfo.entries)
                stdDev += pow(monthInfo.info_mea!.stdDeviation * CGFloat(monthInfo.entries), 2)
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
        distribution = distribution.map { $0 / distSum }
        
        yearEntity.date_info!.entries_attr = Int32(nEntries)
        
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
